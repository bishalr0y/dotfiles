"use strict";var Ke=Object.create;var V=Object.defineProperty;var Je=Object.getOwnPropertyDescriptor;var Ze=Object.getOwnPropertyNames;var qe=Object.getPrototypeOf,Ye=Object.prototype.hasOwnProperty;var Qe=(e,t)=>{for(var r in t)V(e,r,{get:t[r],enumerable:!0})},ue=(e,t,r,n)=>{if(t&&typeof t=="object"||typeof t=="function")for(let a of Ze(t))!Ye.call(e,a)&&a!==r&&V(e,a,{get:()=>t[a],enumerable:!(n=Je(t,a))||n.enumerable});return e};var L=(e,t,r)=>(r=e!=null?Ke(qe(e)):{},ue(t||!e||!e.__esModule?V(r,"default",{value:e,enumerable:!0}):r,e)),Xe=e=>ue(V({},"__esModule",{value:!0}),e);var Et={};Qe(Et,{default:()=>Fe});module.exports=Xe(Et);var q=require("@raycast/api"),Me=require("react");var nt=require("@raycast/api");var he=L(require("fs"));var X=L(require("path"));var et=require("@raycast/api"),tt=()=>{if(!process.env.HOME)throw new Error("$HOME environment variable is not set.");return X.default.join(process.env.HOME,"Library")};var fe=()=>X.default.join(tt(),...de);var rt=()=>{try{let e=fe(),t=he.default.readFileSync(e,"utf-8"),r=JSON.parse(t).profile.info_cache;return r?Object.keys(r)[0]:"Default"}catch{return"Default"}};var de=["Application Support","Google","Chrome","Local State"],z=rt(),ee="CHROME_PROFILE_KEY";var pe=`
  # \u{1F6A8}Error: Google Chrome browser is not installed
  ## This extension depends on Google Chrome browser. You must install it to continue.

  If you have [Homebrew](https://brew.sh/) installed then press \u23CE (Enter Key) to install Google Chrome browser.

  [Click here](https://www.google.com/chrome/) if you want to download manually.

  [![Google Chrome](https://www.google.com/chrome/static/images/chrome-logo-m100.svg)]()
`;var me=`
# \u{1F6A8}Error: Something happened while trying to run your command

[![Google Chrome](https://www.google.com/chrome/static/images/chrome-logo-m100.svg)]()
`,j="An Error Occurred",B="Google Chrome not installed";var at=require("react/jsx-runtime");var ge=require("react"),m=require("@raycast/api"),te=require("child_process");var ye=require("os"),we=require("path"),G=require("react/jsx-runtime"),ot=(()=>{try{return(0,te.execSync)("brew --prefix",{encoding:"utf8"}).trim()}catch{return(0,ye.cpus)()[0].model.includes("Apple")?"/opt/homebrew":"/usr/local"}})();function be(){return(0,we.join)(ot,"bin/brew")}function st(e){try{return(0,te.execSync)(`${be()} install --cask ${e}`,{maxBuffer:10*1024*1024})}catch(t){let r=t;throw r&&r.code===127?(r.stderr=`Brew executable not found at ${be()}`,r):t}}function $e(){let[e,t]=(0,ge.useState)(!0);return(0,G.jsx)(m.Detail,{actions:(0,G.jsx)(m.ActionPanel,{children:e&&(0,G.jsx)(m.Action,{title:"Install with Homebrew",onAction:async()=>{if(!e)return;let r=new m.Toast({style:m.Toast.Style.Animated,title:"Installing..."});await r.show();try{st("google-chrome"),await r.hide()}catch{await r.hide(),await(0,m.showToast)(m.Toast.Style.Failure,j,"An unknown error occurred while trying to install")}r.title="Installed! Please go back and try again.",r.style=m.Toast.Style.Success,await r.show(),t(!1)}})}),markdown:pe})}var N=require("@raycast/api");var xe=require("react/jsx-runtime");function ke(){return(0,N.showToast)(N.Toast.Style.Failure,j,"Something happened while trying to run your command"),(0,xe.jsx)(N.Detail,{markdown:me})}var l=require("@raycast/api");var ve=L(require("node:process"),1),Ee=require("node:util"),re=require("node:child_process"),it=(0,Ee.promisify)(re.execFile);async function C(e,{humanReadableOutput:t=!0,signal:r}={}){if(ve.default.platform!=="darwin")throw new Error("macOS only");let n=t?[]:["-ss"],a={};r&&(a.signal=r);let{stdout:o}=await it("osascript",["-e",e,n],a);return o.trim()}var T=require("@raycast/api");var u=L(require("react")),s=require("@raycast/api");var Se=Object.prototype.hasOwnProperty;function H(e,t){var r,n;if(e===t)return!0;if(e&&t&&(r=e.constructor)===t.constructor){if(r===Date)return e.getTime()===t.getTime();if(r===RegExp)return e.toString()===t.toString();if(r===Array){if((n=e.length)===t.length)for(;n--&&H(e[n],t[n]););return n===-1}if(!r||typeof e=="object"){n=0;for(r in e)if(Se.call(e,r)&&++n&&!Se.call(t,r)||!(r in t)||!H(e[r],t[r]))return!1;return Object.keys(t).length===n}}return e!==e&&t!==t}var I=L(require("node:fs")),K=L(require("node:path"));var _e=require("react/jsx-runtime");var Pe=require("node:url");function ct(e){let t=(0,u.useRef)(e),r=(0,u.useRef)(0);return H(e,t.current)||(t.current=e,r.current+=1),(0,u.useMemo)(()=>t.current,[r.current])}function y(e){let t=(0,u.useRef)(e);return t.current=e,t}function lt(e,t){let r=e instanceof Error?e.message:String(e);return(0,s.showToast)({style:s.Toast.Style.Failure,title:t?.title??"Something went wrong",message:t?.message??r,primaryAction:t?.primaryAction??Te(e),secondaryAction:t?.primaryAction?Te(e):void 0})}var Te=e=>{let t=!0,r="[Extension Name]...",n="";try{let i=JSON.parse((0,I.readFileSync)((0,K.join)(s.environment.assetsPath,"..","package.json"),"utf8"));r=`[${i.title}]...`,n=`https://raycast.com/${i.owner||i.author}/${i.name}`,(!i.owner||i.access==="public")&&(t=!1)}catch{}let a=s.environment.isDevelopment||t,o=e instanceof Error?e?.stack||e?.message||"":String(e);return{title:a?"Copy Logs":"Report Error",onAction(i){i.hide(),a?s.Clipboard.copy(o):(0,s.open)(`https://github.com/raycast/extensions/issues/new?&labels=extension%2Cbug&template=extension_bug_report.yml&title=${encodeURIComponent(r)}&extension-url=${encodeURI(n)}&description=${encodeURIComponent(`#### Error:
\`\`\`
${o}
\`\`\`
`)}`)}}};function Re(e,t,r){let n=(0,u.useRef)(0),[a,o]=(0,u.useState)({isLoading:!0}),i=y(e),d=y(r?.abortable),w=y(t||[]),$=y(r?.onError),k=y(r?.onData),h=y(r?.onWillExecute),g=y(r?.failureToastOptions),x=y(a.data),A=(0,u.useRef)(null),b=(0,u.useRef)({page:0}),Y=(0,u.useRef)(!1),Q=(0,u.useRef)(!0),le=(0,u.useRef)(50),_=(0,u.useCallback)(()=>(d.current&&(d.current.current?.abort(),d.current.current=new AbortController),++n.current),[d]),P=(0,u.useCallback)((...E)=>{let p=_();h.current?.(E),o(c=>({...c,isLoading:!0}));let O=ut(i.current)(...E);function U(c){return c.name=="AbortError"||p===n.current&&($.current?$.current(c):s.environment.launchType!==s.LaunchType.Background&&lt(c,{title:"Failed to fetch latest data",primaryAction:{title:"Retry",onAction(R){R.hide(),A.current?.(...w.current||[])}},...g.current}),o({error:c,isLoading:!1})),c}return typeof O=="function"?(Y.current=!0,O(b.current).then(({data:c,hasMore:R,cursor:Ge})=>(p===n.current&&(b.current&&(b.current.cursor=Ge,b.current.lastItem=c?.[c.length-1]),k.current&&k.current(c,b.current),R&&(le.current=c.length),Q.current=R,o(He=>b.current.page===0?{data:c,isLoading:!1}:{data:(He.data||[])?.concat(c),isLoading:!1})),c),c=>(Q.current=!1,U(c)))):(Y.current=!1,O.then(c=>(p===n.current&&(k.current&&k.current(c),o({data:c,isLoading:!1})),c),U))},[k,$,w,i,o,A,h,b,g,_]);A.current=P;let W=(0,u.useCallback)(()=>{b.current={page:0};let E=w.current||[];return P(...E)},[P,w]),We=(0,u.useCallback)(async(E,p)=>{let O;try{if(p?.optimisticUpdate){_(),typeof p?.rollbackOnError!="function"&&p?.rollbackOnError!==!1&&(O=structuredClone(x.current?.value));let U=p.optimisticUpdate;o(c=>({...c,data:U(c.data)}))}return await E}catch(U){if(typeof p?.rollbackOnError=="function"){let c=p.rollbackOnError;o(R=>({...R,data:c(R.data)}))}else p?.optimisticUpdate&&p?.rollbackOnError!==!1&&o(c=>({...c,data:O}));throw U}finally{p?.shouldRevalidateAfter!==!1&&(s.environment.launchType===s.LaunchType.Background||s.environment.commandMode==="menu-bar"?await W():W())}},[W,x,o,_]),Ve=(0,u.useCallback)(()=>{b.current.page+=1;let E=w.current||[];P(...E)},[b,w,P]);(0,u.useEffect)(()=>{b.current={page:0},r?.execute!==!1?P(...t||[]):_()},[ct([t,r?.execute,P]),d,b]),(0,u.useEffect)(()=>()=>{_()},[_]);let ze=r?.execute!==!1?a.isLoading:!1,je={...a,isLoading:ze},Be=Y.current?{pageSize:le.current,hasMore:Q.current,onLoadMore:Ve}:void 0;return{...je,revalidate:W,mutate:We,pagination:Be}}function ut(e){return e===Promise.all||e===Promise.race||e===Promise.resolve||e===Promise.reject?e.bind(Promise):e}function ft(e,t){let r=this[e];return r instanceof Date?`__raycast_cached_date__${r.toString()}`:Buffer.isBuffer(r)?`__raycast_cached_buffer__${r.toString("base64")}`:t}function dt(e,t){return typeof t=="string"&&t.startsWith("__raycast_cached_date__")?new Date(t.replace("__raycast_cached_date__","")):typeof t=="string"&&t.startsWith("__raycast_cached_buffer__")?Buffer.from(t.replace("__raycast_cached_buffer__",""),"base64"):t}var ht=Symbol("cache without namespace"),Ae=new Map;function ne(e,t,r){let n=r?.cacheNamespace||ht,a=Ae.get(n)||Ae.set(n,new s.Cache({namespace:r?.cacheNamespace})).get(n);if(!a)throw new Error("Missing cache");let o=y(e),i=y(t),d=(0,u.useSyncExternalStore)(a.subscribe,()=>{try{return a.get(o.current)}catch(h){console.error("Could not get Cache data:",h);return}}),w=(0,u.useMemo)(()=>{if(typeof d<"u"){if(d==="undefined")return;try{return JSON.parse(d,dt)}catch(h){return console.warn("The cached data is corrupted",h),i.current}}else return i.current},[d,i]),$=y(w),k=(0,u.useCallback)(h=>{let g=typeof h=="function"?h($.current):h;if(typeof g>"u")a.set(o.current,"undefined");else{let x=JSON.stringify(g,ft);a.set(o.current,x)}return g},[a,o,$]);return[w,k]}function J(e,t){let r=n=>n.startsWith("http")?n:`https://${n}`;try{let n=d=>d.startsWith("http")?d:`https://${d}`,o=(typeof e=="string"?new Pe.URL(n(e)):e).hostname;switch(process.env.FAVICON_PROVIDER??"raycast"){case"none":return{source:t?.fallback??s.Icon.Link,mask:t?.mask};case"apple":return{source:t?.fallback??s.Icon.Link,mask:t?.mask};case"duckduckgo":case"duckDuckGo":return{source:`https://icons.duckduckgo.com/ip3/${o}.ico`,fallback:t?.fallback??s.Icon.Link,mask:t?.mask};case"google":return{source:`https://www.google.com/s2/favicons?sz=${t?.size??64}&domain=${o}`,fallback:t?.fallback??s.Icon.Link,mask:t?.mask};case"legacy":case"raycast":default:return{source:`https://api.ray.so/favicon?url=${o}&size=${t?.size??64}`,fallback:t?.fallback??s.Icon.Link,mask:t?.mask}}}catch(n){return console.error(n),s.Icon.Link}}var S=class e{constructor(t,r,n,a,o,i){this.title=t;this.url=r;this.favicon=n;this.windowsId=a;this.tabIndex=o;this.sourceLine=i}static TAB_CONTENTS_SEPARATOR="~~~";static parse(t){let r=t.split(this.TAB_CONTENTS_SEPARATOR);return new e(r[0],r[1],r[2],+r[3],+r[4],t)}key(){return`${this.windowsId}${e.TAB_CONTENTS_SEPARATOR}${this.tabIndex}`}urlWithoutScheme(){try{return this.url.replace(/(^\w+:|^)\/\//,"").replace("www.","")}catch{return this.url}}realFavicon(){try{return new URL(this.favicon||"/favicon.ico",this.url).href}catch{return this.favicon||""}}googleFavicon(){try{return J(this.url)}catch{return{source:""}}}};async function Ce(e){let t=e?`execute t javascript \xAC
        "document.head.querySelector('link[rel~=icon]') ? document.head.querySelector('link[rel~=icon]').href : '';"`:'""';await ae();try{return(await C(`
      set _output to ""
      tell application "Google Chrome"
        repeat with w in windows
          set _w_id to get id of w as inches as string
          set _tab_index to 1
          repeat with t in tabs of w
            set _title to get title of t
            set _url to get URL of t
            set _favicon to ${t}
            set _output to (_output & _title & "${S.TAB_CONTENTS_SEPARATOR}" & _url & "${S.TAB_CONTENTS_SEPARATOR}" & _favicon & "${S.TAB_CONTENTS_SEPARATOR}" & _w_id & "${S.TAB_CONTENTS_SEPARATOR}" & _tab_index & "\\n")
            set _tab_index to _tab_index + 1
          end repeat
        end repeat
      end tell
      return _output
  `)).split(`
`).filter(n=>n.length!==0).map(n=>S.parse(n))}catch(r){return r.message.includes(`Can't get application "Google Chrome"`)&&T.LocalStorage.removeItem("is-installed"),await ae(),[]}}async function D({url:e,query:t,profileCurrent:r,profileOriginal:n,openTabInProfile:a}){setTimeout(()=>{(0,T.popToRoot)({clearSearchBar:!0})},3e3),await Promise.all([(0,T.closeMainWindow)({clearRootSearch:!0}),ae()]);let o="",i=d=>`
    set profile to quoted form of "${d}"
    set link to quoted form of "${e||"about:blank"}"
    do shell script "open -na 'Google Chrome' --args --profile-directory=" & profile & " " & link
  `;switch(a){case"default":o=`
        set winExists to false
        tell application "Google Chrome"
            repeat with win in every window
                if index of win is 1 then
                    set winExists to true
                    exit repeat
                end if
            end repeat

            if not winExists then
                make new window
            else
                activate
            end if

            tell window 1
                set newTab to make new tab `+(e?`with properties {URL:"${e}"}`:t?'with properties {URL:"https://www.google.com/search?q='+t+'"}':"")+`
            end tell
        end tell
        return true

  `;break;case"profile_current":o=i(r);break;case"profile_original":o=i(n);break}return await C(o)}async function Ie(e){await C(`
    tell application "Google Chrome"
      activate
      set _wnd to first window where id is ${e.windowsId}
      set index of _wnd to 1
      set active tab index of _wnd to ${e.tabIndex}
    end tell
    return true
  `)}async function Oe(e){await C(`
    tell application "Google Chrome"
      activate
      set _wnd to first window where id is ${e.windowsId}
      set index of _wnd to 1
      set active tab index of _wnd to ${e.tabIndex}
      close active tab of _wnd
    end tell
    return true
  `)}async function Ue(e){await C(`
    tell application "Google Chrome"
      activate
      set _wnd to first window where id is ${e.windowsId}
      set index of _wnd to 1
      set active tab index of _wnd to ${e.tabIndex}
      tell active tab of _wnd to reload
    end tell
    return true
  `)}var ae=async()=>{if(await T.LocalStorage.getItem("is-installed"))return;if(await C(`
set isInstalled to false
try
    do shell script "osascript -e 'exists application \\"Google Chrome\\"'"
    set isInstalled to true
end try

return isInstalled`)==="false")throw new Error(B);T.LocalStorage.setItem("is-installed",!0)};var f=require("react/jsx-runtime"),M=class{static NewTab=mt;static TabList=bt;static TabHistory=gt};function mt({query:e,url:t}){let{openTabInProfile:r}=(0,l.getPreferenceValues)(),[n]=ne(ee,z),a="Open Empty Tab";return e?a=`Search "${e}"`:t&&(a=`Open URL "${t}"`),(0,f.jsx)(l.ActionPanel,{title:"New Tab",children:(0,f.jsx)(l.Action,{onAction:()=>D({url:t,query:e,profileCurrent:n,openTabInProfile:r}),title:a})})}function bt({tab:e,onTabClosed:t}){return(0,f.jsxs)(l.ActionPanel,{title:e.title,children:[(0,f.jsx)(yt,{tab:e}),(0,f.jsx)($t,{tab:e}),(0,f.jsx)(l.Action.CopyToClipboard,{title:"Copy URL",content:e.url}),(0,f.jsx)(l.Action.CopyToClipboard,{title:"Copy Title",content:e.title,shortcut:{modifiers:["cmd","shift"],key:"enter"}}),(0,f.jsx)(wt,{tab:e,onTabClosed:t}),(0,f.jsx)(l.ActionPanel.Section,{children:(0,f.jsx)(l.Action.CreateQuicklink,{quicklink:{link:e.url,name:e.title,application:"Google Chrome"},shortcut:{modifiers:["cmd"],key:"s"}})})]})}function gt({title:e,url:t,profile:r}){let{openTabInProfile:n}=(0,l.getPreferenceValues)(),[a]=ne(ee,z);return(0,f.jsxs)(l.ActionPanel,{title:e,children:[(0,f.jsx)(l.Action,{onAction:()=>D({url:t,profileOriginal:r,profileCurrent:a,openTabInProfile:n}),title:"Open"}),(0,f.jsxs)(l.ActionPanel.Section,{title:"Open in profile",children:[(0,f.jsx)(l.Action,{onAction:()=>D({url:t,profileOriginal:r,profileCurrent:a,openTabInProfile:"profile_current"}),title:"Open in Current Profile"}),(0,f.jsx)(l.Action,{onAction:()=>D({url:t,profileOriginal:r,profileCurrent:a,openTabInProfile:"profile_original"}),title:"Open in Original Profile"})]}),(0,f.jsx)(l.Action.CopyToClipboard,{title:"Copy URL",content:t,shortcut:{modifiers:["cmd"],key:"c"}})]})}function yt(e){async function t(){try{await Ie(e.tab),await(0,l.closeMainWindow)()}catch(r){throw r instanceof Error?new Error("Issue with tab: '"+e.tab.sourceLine+`'
`+r.message):r}}return(0,f.jsx)(l.ActionPanel.Item,{title:"Open Tab",icon:{source:l.Icon.Eye},onAction:t})}function wt(e){async function t(){await Oe(e.tab),await(0,l.closeMainWindow)(),e.onTabClosed?.()}return(0,f.jsx)(l.Action,{title:"Close Tab",icon:{source:l.Icon.XMarkCircle},onAction:t,shortcut:{modifiers:["cmd","shift"],key:"w"}})}function $t(e){async function t(){try{await Ue(e.tab),await(0,l.closeMainWindow)()}catch(r){throw r instanceof Error?new Error("Issue with tab: '"+e.tab.sourceLine+`'
`+r.message):r}}return(0,f.jsx)(l.Action,{title:"Reload Tab",icon:{source:l.Icon.ArrowClockwise},onAction:t,shortcut:{modifiers:["cmd","shift"],key:"r"}})}var v=require("@raycast/api");var F=require("react/jsx-runtime"),Z=class{static TabList=vt;static TabHistory=xt};function kt(e){let t=["javascript:","data:","about:","chrome:","file:"],r=e.toLowerCase().trim();if(t.some(n=>r.startsWith(n)))return{icon:{source:v.Icon.ExclamationMark,tintColor:v.Color.Orange},isInvalid:!0};try{return new URL(e),{icon:J(e),isInvalid:!1}}catch{return{icon:{source:v.Icon.ExclamationMark,tintColor:v.Color.Orange},isInvalid:!0}}}function xt({profile:e,entry:{url:t,title:r,id:n},type:a}){let{icon:o,isInvalid:i}=kt(t);return(0,F.jsx)(v.List.Item,{id:`${e}-${a}-${n}`,title:r,subtitle:t,icon:o,accessories:i?[{text:"\u26A0\uFE0F Invalid URL - Cannot open",tooltip:"This URL uses an unsupported protocol"}]:void 0,actions:(0,F.jsx)(M.TabHistory,{title:r,url:t,profile:e})})}function vt(e){return(0,F.jsx)(v.List.Item,{title:e.tab.title,subtitle:e.tab.urlWithoutScheme(),keywords:[e.tab.urlWithoutScheme()],actions:(0,F.jsx)(M.TabList,{tab:e.tab,onTabClosed:e.onTabClosed}),icon:e.useOriginalFavicon?e.tab.realFavicon():e.tab.googleFavicon()})}var se=require("react");var Ne=require("@raycast/api");function Le(e){if(!e)return{includeTerms:[],excludeTerms:[]};let t=e.trim().split(/\s+/),r=[],n=[];for(let a of t)a.startsWith("\\-")&&a.length>1?r.push(a.slice(1).toLowerCase()):a.startsWith("-")&&a.length>1?n.push(a.slice(1).toLowerCase()):a.length>0&&a!=="-"&&r.push(a.toLowerCase());return{includeTerms:r,excludeTerms:n}}function oe(e,t){let{includeTerms:r,excludeTerms:n}=t,a=r.length===0||r.every(i=>e.includes(i)),o=n.length===0||!n.some(i=>e.includes(i));return a&&o}var ie=require("react/jsx-runtime");function De(e=""){let{useOriginalFavicon:t}=(0,Ne.getPreferenceValues)(),[r,n]=(0,se.useState)(),[a,o]=(0,se.useState)(!1),{isLoading:i,data:d}=Re(async($,k)=>{let h=await Ce($),g=Le(k);return n(void 0),o(h.length===0),g.includeTerms.length===0&&g.excludeTerms.length===0?h:h.filter(x=>{try{let A=`${x.title.toLowerCase()} ${x.urlWithoutScheme().toLowerCase()}`;return oe(A,g)}catch{let A=`${x.title.toLowerCase()} ${x.url.toLowerCase()}`;return oe(A,g)}})},[t,e],{onError($){$.message===B?n((0,ie.jsx)($e,{})):n((0,ie.jsx)(ke,{}))}});return{data:a?[]:d||[],isLoading:i,errorView:r}}var ce=require("react/jsx-runtime");function Fe(){let{useOriginalFavicon:e}=(0,q.getPreferenceValues)(),[t,r]=(0,Me.useState)(""),{data:n,errorView:a,isLoading:o}=De(t);return a??(0,ce.jsx)(q.List,{isLoading:o,onSearchTextChange:r,children:n.map(i=>(0,ce.jsx)(Z.TabList,{tab:i,useOriginalFavicon:e},i.key()))})}
