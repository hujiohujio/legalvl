function post (){
  const submit = document.getElementById("submit_btn");
  submit.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("new_article"));    
    const XHR = new XMLHttpRequest();
    XHR.open("POST", `/articles/${gon.article.id}/messages`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const item = XHR.response.message;
      const contentsArea = document.getElementById("message");
      const articleText = document.getElementById("message_text_field");
      const HTML = `
        <div class="upper-message">
          <div class="message-user">
            ${ gon.user }
          </div>
          <div class="message-date">
            ${ gon.time }
          </div>
        </div>
        <div class="lower-message">
          <div class="message-content" id= "message_content" >
            ${ item.content }
          </div>
        </div>        
  
      `;

      contentsArea.insertAdjacentHTML("afterbegin", HTML);
      articleText.value = "";
      console.log(contentsArea)
    };
    e.preventDefault();
  });
}
window.addEventListener('load', post);