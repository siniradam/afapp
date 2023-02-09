/**
 *
 * @param {String} path
 * @param {"POST"|"GET"|"PUT"|"DELETE"|"PATCH"} method
 * @param {Object} body
 * @param {String|undefined|null=} token
 * @returns
 */
export const request = async (path, method, body = {}, token) => {
  //
  let options = {
    method,
    headers: {
      "content-type": "application/json",
    },
  };

  // console.log(path == '/profile/wallet/' ? body : '');

  //Anything but GET
  if (method.toLowerCase() != "get") {
    options.body = JSON.stringify({ ...body, token });

    //GET
  } else {
    let params = Object.keys(body).map((key) => {
      return `${key}=${body[key]}`;
    });
    path += path.indexOf("?") == -1 ? "?" : "&";
    path += params.join("&");
  }

  return await fetch(path, options);
};
