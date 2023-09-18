    const RECORDRTP = 0;  //录制一份未经过转封装的码流原始数据，用于定位问题
    self.Module = { memoryInitializerRequest: loadMemInitFile(), TOTAL_MEMORY: 128*1024*1024 };
    importScripts = (function (globalEval) {
        var xhr = new XMLHttpRequest;
        return function importScripts() {
          var
            args = Array.prototype.slice.call(arguments)
            , len = args.length
            , i = 0
            , meta
            , data
            , content
            ;
          for (; i < len; i++) {
            if (args[i].substr(0, 5).toLowerCase() === "data:") {
              data = args[i];
              content = data.indexOf(",");
              meta = data.substr(5, content).toLowerCase();
              data = decodeURIComponent(data.substr(content + 1));
              if (/;\s*base64\s*[;,]/.test(meta)) {
                data = atob(data);
              }
              if (/;\s*charset=[uU][tT][fF]-?8\s*[;,]/.test(meta)) {
                data = decodeURIComponent(escape(data));
              }
            } else {
              xhr.open("GET", args[i], false);
              xhr.send(null);
              data = xhr.responseText;
            }
            globalEval(data);
          }
        };
      }(eval));
    importScripts('${staticPath}/js/transform/SystemTransform.js');

    Module.postRun.push(function() {
        postMessage({type: "loaded"});
    });

    onmessage = function (e) {
        var data = e.data;

        if ("create" === data.type) {
            var iHeadLen = data.len;
            var pHead = Module._malloc(iHeadLen);

            var aData = Module.HEAPU8.subarray(pHead, pHead + iHeadLen);
            aData.set(new Uint8Array(data.buf));

            var iTransType = data.packType;//目标格式 RTP->PS
            if (RECORDRTP) {
                postMessage({type: "created"});
                postMessage({type: "outputData", buf: data.buf, dType: 1}, [data.buf]);
            } else {
                var iRet = Module._ST_Create(pHead, iHeadLen, iTransType);
                if (iRet != 0) {
                    console.log("_ST_Create failed!");
                } else {
                    Module._ST_Start();
                    postMessage({type: "created"});
                }
            }

        } else if ("inputData" === data.type) {
            if (RECORDRTP) {
                var aFileData = new Uint8Array(data.buf);  // 拷贝一份
                var iBufferLen = aFileData.length;
                var szBufferLen = iBufferLen.toString(16);
                if (szBufferLen.length === 1) {
                    szBufferLen = "000" + szBufferLen;
                } else if (szBufferLen.length === 2) {
                    szBufferLen = "00" + szBufferLen;
                } else if (szBufferLen.length === 3) {
                    szBufferLen = "0" + szBufferLen;
                }
                var aData = [0, 0, parseInt(szBufferLen.substring(0, 2), 16), parseInt(szBufferLen.substring(2, 4), 16)];
                for(var iIndex = 0, iDataLength = aFileData.length; iIndex < iDataLength; iIndex++) {
                    aData[iIndex + 4] = aFileData[iIndex]
                }
                var dataUint8 = new Uint8Array(aData);
                postMessage({type: "outputData", buf: dataUint8.buffer, dType: 2}, [dataUint8.buffer]);
            } else {
                var iDataLen = data.len;
                var pData = Module._malloc(iDataLen);

                var aData = Module.HEAPU8.subarray(pData, pData + iDataLen);
                aData.set(new Uint8Array(data.buf));

                var iRet = Module._ST_InputData(0, pData, iDataLen);
                if (iRet != 0) {
                    //console.log("_ST_InputData failed!");// 一开始会有一些失败，但是不影响后面的文件存储
                }

                Module._free(pData);
            }
        } else if ("release" === data.type) {
            Module._ST_Stop();
            Module._ST_Release();

            close();
        }
    };

    function loadMemInitFile() {
        var req = new XMLHttpRequest();
        req.open('GET', '${staticPath}/js/transform/SystemTransform.js.mem');
        req.responseType = 'arraybuffer';
        req.send();

        return req;
    }