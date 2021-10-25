function defaultErrorHandler(error, request, response, next) {
  response.status(500).json({
    message: error.message,
    stack: error.stack,
  });
}

function errorHandler(error, request, response, next) {
  if (error.isBoom) {
    const { output } = error;

    response.status(output.statusCode).json(output.payload);
  }
  next(error);
}

module.exports = { errorHandler, defaultErrorHandler };
