var assert = require('chai').assert
var wintersmith = require('wintersmith')

describe('sandbox plugin', function() {
	var env = wintersmith('./example/config.json');

	it('loaded wintersmith correctly', function(done) {
		assert.instanceOf(env, wintersmith.Environment);
		done();
	});

	it('loads the content correctly', function(done) {
		env.load(function(error, result) {
			if (error) {
				done(error);
			} else {
				assert.instanceOf(result.contents['index.sandboxjs'], wintersmith.ContentPlugin);
				assert.isArray(result.contents._.sandbox);
				assert.lengthOf(result.contents._.sandbox, 1);
				console.log(result.contents._.sandbox);
				done();
			}
		});
	});
});
