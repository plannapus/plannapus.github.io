import('https://webr.r-wasm.org/latest/webr.mjs').then(async ({WebR}) => {
    let grid = document.getElementById("rspace");
    const webr = new WebR();
    await webr.init();
    let func = "f=function() paste(sample(1:100,10),collapse=', ')";
    await webr.evalR(func);
    let str = await webr.evalR('f()')
    grid.innerHTML = (await str.toJs()).values;

    async function randomize() {
        await webr.objs.globalEnv.bind('str', grid.innerHTML)
        let str = await webr.evalR('f()')
        grid.innerHTML = (await str.toJs()).values;
    }

    globalThis.randomize = () => {
        randomize()
      }
});