
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/html">
  <head>
    <title>HDFS读写性能测试界面</title>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">

      <link href="/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
      <script src="/js/jquery.min.js" type="text/javascript"></script>
      <script src="/assets/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
  </head>
  
  <body>

  <div class="container">
        <div class="jumbotron">
            <h2>HDFS读写性能BenchMark</h2>
            <#--<div class="row center-block">-->
                <#--<div class="btn-group" role="group" aria-label="...">-->
                    <#--<button id="showresult" type="button" class="btn btn-primary">显示结果</button>-->
                    <#--<button id="savereslut" type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveresultModal">保存当前结果</button>-->
                <#--</div>-->
            <#--</div>-->
        </div>

      <div class="row">
          <div class="col-md-6">
              <div class="panel panel-primary">
                  <div class="panel-heading">
                      <h3 class="panel-title">配置BenchMark性能测试参数</h3>
                  </div>
                  <div class="panel-body">
                      <div class="row">
                          <div id="modelRadiosGroup" class="col-md-12 text-center">
                              <label class="radio">
                                  <input type="radio" name="modelRadios" id="readRadios" value="read" checked>
                                  测试读取文件能力
                              </label>
                              <label class="radio">
                                  <input type="radio" name="modelRadios" id="writeRadios" value="write">
                                  测试写入文件能力
                              </label>
                          </div>
                      </div>

                      <div class="row">
                          <div class="col-md-6">
                              <div class="input-group">
                                  <span class="input-group-addon">文件大小(单位 Mb)</span>
                                  <input id="filesize" type="number" class="form-control" placeholder="filesize">
                              </div>
                          </div>
                          <div class="col-md-6">
                              <div class="input-group">
                                  <span class="input-group-addon">文件个数</span>
                                  <input id="filenum" type="number" class="form-control" placeholder="filenum">
                              </div>
                          </div>
                      </div>
                      </br>
                      <div class="row">
                          <div class="btn-group" role="group" aria-label="...">
                              <button id="startBenchMark" type="button" class="btn btn-primary">开始测试</button>
                              <button id="cleanTemporaryFiles" type="button" class="btn btn-primary" data-toggle="modal">清空临时文件</button>
                              <button id="cleanconf" type="button" class="btn btn-primary" data-toggle="modal">清空参数</button>
                              <button id="showresult" type="button" class="btn btn-primary" data-toggle="modal">显示测试结果</button>
                              <button id="cleanresult" type="button" class="btn btn-primary" data-toggle="modal">清空测试结果</button>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
          <div class="col-md-6">
              <div class="row">
                  <div class="form-group">
                      <label for="name">输出结果</label>
                      <textarea id="resultTextarea" class="form-control" rows="20"></textarea>
                  </div>
              </div>
          </div>
      </div>
  </div>
            <!-- 模态框（Modal） -->
            <div class="modal fade" id="loaddata" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false"
                 aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-body">
                            <h3>正在加载中........</h3>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>

         <script type="text/javascript">
             // init()方法
             $(function () {
                 showresult();
                $("#startBenchMark").click(function() {
                    //var url="http://node262:8080/hdfsAnalysis/testDFSIO";
                    var url="/hdfsAnalysis/testDFSIO";
                    var filesize=$("#filesize").val();
                    var filenum=$("#filenum").val();
                    var modelRadios = $('#modelRadiosGroup input[name="modelRadios"]:checked ').val();
                    if(filesize<=0 || filenum<=0){
                        alert("请输入正确的参数")
                        return;
                    }
                    $('#loaddata').modal('show');
                    $.ajax({
                        url:url,
                        dataType:'json',
                        data:{'filesize':filesize,'filenum':filenum,'modelRadios':modelRadios},
                        type:"post",
                        success:function(data){
                            alert("聚合吞吐率为："+data+" MB/s");
                            showresult();
                            //echartsRedBrokenLineInit(myChart, data, 'Storm输入源吞吐量测试结果');
                            $('#loaddata').modal('hide')
                        },
                        error:function(XMLHttpRequest, textStatus, errorThrown) {
                            alert(XMLHttpRequest.status);
                            alert(XMLHttpRequest.readyState);
                            alert(textStatus);
                        }
                    });
                }) ;

                 $("#cleanTemporaryFiles").click(function () {
                     $('#loaddata').modal('show');
                     var url="/hdfsAnalysis/cleanTemporaryFiles";
                     $.ajax({
                         url:url,
                         dataType:'json',
                         data:{},
                         type:"post",
                         success:function(data){
                             alert("清除成功~")
                             //echartsRedBrokenLineInit(myChart, data, 'Storm输入源吞吐量测试结果');
                             $('#loaddata').modal('hide')
                         },
                         error:function(XMLHttpRequest, textStatus, errorThrown) {
                             alert(XMLHttpRequest.status);
                             alert(XMLHttpRequest.readyState);
                             alert(textStatus);
                         }
                     });
                 });

                 $("#cleanconf").click(function () {
                     $("#filesize").val(0);
                     $("#filenum").val(0);
                 });

                 $("#showresult").click(function () {
                     showresult();
                 });

                 $("#cleanresult").click(function () {
                     $('#loaddata').modal('show');
                     var url="/hdfsAnalysis/cleanresult";
                     $.ajax({
                         url:url,
                         dataType:'json',
                         data:{},
                         type:"post",
                         success:function(data){
                             alert("清除成功~");
                             showresult();
                             //echartsRedBrokenLineInit(myChart, data, 'Storm输入源吞吐量测试结果');
                             $('#loaddata').modal('hide')
                         },
                         error:function(XMLHttpRequest, textStatus, errorThrown) {
                             alert(XMLHttpRequest.status);
                             alert(XMLHttpRequest.readyState);
                             alert(textStatus);
                         }
                     });
                 });
             });

         </script>
      <script type="text/javascript">

          function replaceTextarea1(str){
//              var reg=new RegExp("\r","g");
//              str = str.replace(reg,"\r\n");
              return str;
          }

          function showresult(){
              $('#loaddata').modal('show');
              var url="/hdfsAnalysis/showresult";
              $.ajax({
                  url:url,
                  dataType:'json',
                  data:{},
                  type:"post",
                  success:function(data){
                      $("#resultTextarea").val(data);
                      //echartsRedBrokenLineInit(myChart, data, 'Storm输入源吞吐量测试结果');
                      $('#loaddata').modal('hide')
                  },
                  error:function(XMLHttpRequest, textStatus, errorThrown) {
                      alert(XMLHttpRequest.status);
                      alert(XMLHttpRequest.readyState);
                      alert(textStatus);
                  }
              });
          }

      </script>
  </body>
</html>
