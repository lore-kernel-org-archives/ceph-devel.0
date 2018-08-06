From: Will Zhao <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: questions about rbd_discard, python API
Date: Mon, 6 Aug 2018 15:08:13 +0800
Message-ID: <CAGOEmcOQCHkkpBqwyqLwebJ0_iMY=-5rMsguzTGCqDoeaFH0vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3151090648641297227=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3151090648641297227==
Content-Type: multipart/alternative; boundary="0000000000009aa61a0572bef177"

--0000000000009aa61a0572bef177
Content-Type: text/plain; charset="UTF-8"

Hi all: extern "C" int rbd_discard(rbd_image_t image, uint64_t ofs, uint64_t
len)
{
librbd::ImageCtx *ictx = (librbd::ImageCtx *)image;
tracepoint(librbd, discard_enter, ictx, ictx->name.c_str(),
ictx->snap_name.c_str(), ictx->read_only, ofs, len);
if (len > std::numeric_limits<int>::max()) {
tracepoint(librbd, discard_exit, -EINVAL);
return -EINVAL;
}
int r = ictx->io_work_queue->discard(ofs, len, ictx->skip_partial_discard);
tracepoint(librbd, discard_exit, r);
return r;
} I tried to call rbd python api, rbd.Image.discard , and I found there is
limit to the parameter len , it is a uint64, but is limited by
std::numeric_limits<int>::max(), so that I can't discard too large space at
a time. So I wonder what the considerations are about this?

--0000000000009aa61a0572bef177
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

<table class=3D"gmail-highlight gmail-tab-size gmail-js-file-line-container=
" style=3D"box-sizing:border-box;border-collapse:collapse;color:rgb(36,41,4=
6);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvet=
ica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quo=
t;,&quot;Segoe UI Symbol&quot;;font-size:14px;text-decoration-style:initial=
;text-decoration-color:initial"><tbody style=3D"box-sizing:border-box"><tr =
style=3D"box-sizing:border-box"></tr><tr style=3D"box-sizing:border-box"><t=
d id=3D"gmail-LC4029" class=3D"gmail-blob-code gmail-blob-code-inner gmail-=
js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;line-height:2=
0px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas=
,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;color:r=
gb(36,41,46);word-wrap:normal;white-space:pre"><span class=3D"gmail-pl-k" s=
tyle=3D"box-sizing:border-box;color:rgb(215,58,73)">Hi all:=20
extern</span> <span class=3D"gmail-pl-s" style=3D"box-sizing:border-box;col=
or:rgb(3,47,98)"><span class=3D"gmail-pl-pds" style=3D"box-sizing:border-bo=
x;color:rgb(3,47,98)">&quot;</span>C<span class=3D"gmail-pl-pds" style=3D"b=
ox-sizing:border-box;color:rgb(3,47,98)">&quot;</span></span> <span class=
=3D"gmail-pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">int</s=
pan> <span class=3D"gmail-pl-en" style=3D"box-sizing:border-box;color:rgb(1=
11,66,193)">rbd_discard</span>(<span class=3D"gmail-pl-c1" style=3D"box-siz=
ing:border-box;color:rgb(0,92,197)">rbd_image_t</span> image, <span class=
=3D"gmail-pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">uint64=
_t</span> ofs, <span class=3D"gmail-pl-c1" style=3D"box-sizing:border-box;c=
olor:rgb(0,92,197)">uint64_t</span> len)
<table class=3D"gmail-highlight gmail-tab-size gmail-js-file-line-container=
" style=3D"white-space:normal;text-decoration-style:initial;text-decoration=
-color:initial;box-sizing:border-box;border-collapse:collapse;font-family:-=
apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-s=
erif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe U=
I Symbol&quot;;font-size:14px"><tbody style=3D"box-sizing:border-box"><tr s=
tyle=3D"box-sizing:border-box"><td id=3D"gmail-LC4030" class=3D"gmail-blob-=
code gmail-blob-code-inner gmail-js-file-line" style=3D"font-family:SFMono-=
Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin=
:0px;box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align=
:top;overflow:visible;font-size:12px;color:rgb(36,41,46);word-wrap:normal;w=
hite-space:pre">{</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gm=
ail-L4031" class=3D"gmail-blob-num gmail-js-line-number" style=3D"font-fami=
ly:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monosp=
ace;margin:0px;box-sizing:border-box;padding:0px 10px;width:50px;min-width:=
50px;font-size:12px;line-height:20px;color:rgba(27,31,35,0.3);text-align:ri=
ght;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-LC4031" cla=
ss=3D"gmail-blob-code gmail-blob-code-inner gmail-js-file-line" style=3D"fo=
nt-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier=
,monospace;margin:0px;box-sizing:border-box;padding:0px 10px;line-height:20=
px;vertical-align:top;overflow:visible;font-size:12px;color:rgb(36,41,46);w=
ord-wrap:normal;white-space:pre">  librbd::ImageCtx *ictx =3D (librbd::Imag=
eCtx *)image;</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-=
L4032" class=3D"gmail-blob-num gmail-js-line-number" style=3D"font-family:S=
FMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;=
margin:0px;box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px=
;font-size:12px;line-height:20px;color:rgba(27,31,35,0.3);text-align:right;=
white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-LC4032" class=
=3D"gmail-blob-code gmail-blob-code-inner gmail-js-file-line" style=3D"font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,m=
onospace;margin:0px;box-sizing:border-box;padding:0px 10px;line-height:20px=
;vertical-align:top;overflow:visible;font-size:12px;color:rgb(36,41,46);wor=
d-wrap:normal;white-space:pre">  <span class=3D"gmail-pl-c1" style=3D"box-s=
izing:border-box;color:rgb(0,92,197)">tracepoint</span>(librbd, discard_ent=
er, ictx, ictx-&gt;<span class=3D"gmail-pl-smi" style=3D"box-sizing:border-=
box;color:rgb(36,41,46)">name</span>.<span class=3D"gmail-pl-c1" style=3D"b=
ox-sizing:border-box;color:rgb(0,92,197)">c_str</span>(),</td></tr><tr styl=
e=3D"box-sizing:border-box"><td id=3D"gmail-L4033" class=3D"gmail-blob-num =
gmail-js-line-number" style=3D"font-family:SFMono-Regular,Consolas,&quot;Li=
beration Mono&quot;,Menlo,Courier,monospace;margin:0px;box-sizing:border-bo=
x;padding:0px 10px;width:50px;min-width:50px;font-size:12px;line-height:20p=
x;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;vertical-ali=
gn:top"></td><td id=3D"gmail-LC4033" class=3D"gmail-blob-code gmail-blob-co=
de-inner gmail-js-file-line" style=3D"font-family:SFMono-Regular,Consolas,&=
quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px;box-sizing:bo=
rder-box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visi=
ble;font-size:12px;color:rgb(36,41,46);word-wrap:normal;white-space:pre">  =
           ictx-&gt;<span class=3D"gmail-pl-smi" style=3D"box-sizing:border=
-box;color:rgb(36,41,46)">snap_name</span>.<span class=3D"gmail-pl-c1" styl=
e=3D"box-sizing:border-box;color:rgb(0,92,197)">c_str</span>(), ictx-&gt;<s=
pan class=3D"gmail-pl-smi" style=3D"box-sizing:border-box;color:rgb(36,41,4=
6)">read_only</span>, ofs, len);</td></tr><tr style=3D"box-sizing:border-bo=
x"><td id=3D"gmail-L4034" class=3D"gmail-blob-num gmail-js-line-number" sty=
le=3D"font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo=
,Courier,monospace;margin:0px;box-sizing:border-box;padding:0px 10px;width:=
50px;min-width:50px;font-size:12px;line-height:20px;color:rgba(27,31,35,0.3=
);text-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D"gm=
ail-LC4034" class=3D"gmail-blob-code gmail-blob-code-inner gmail-js-file-li=
ne" style=3D"font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot=
;,Menlo,Courier,monospace;margin:0px;box-sizing:border-box;padding:0px 10px=
;line-height:20px;vertical-align:top;overflow:visible;font-size:12px;color:=
rgb(36,41,46);word-wrap:normal;white-space:pre">  <span class=3D"gmail-pl-k=
" style=3D"box-sizing:border-box;color:rgb(215,58,73)">if</span> (len &gt; =
std::numeric_limits&lt;<span class=3D"gmail-pl-k" style=3D"box-sizing:borde=
r-box;color:rgb(215,58,73)">int</span>&gt;::<span class=3D"gmail-pl-c1" sty=
le=3D"box-sizing:border-box;color:rgb(0,92,197)">max</span>()) {</td></tr><=
tr style=3D"box-sizing:border-box"><td id=3D"gmail-L4035" class=3D"gmail-bl=
ob-num gmail-js-line-number" style=3D"font-family:SFMono-Regular,Consolas,&=
quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px;box-sizing:bo=
rder-box;padding:0px 10px;width:50px;min-width:50px;font-size:12px;line-hei=
ght:20px;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;verti=
cal-align:top"></td><td id=3D"gmail-LC4035" class=3D"gmail-blob-code gmail-=
blob-code-inner gmail-js-file-line" style=3D"font-family:SFMono-Regular,Con=
solas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px;box-si=
zing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;overfl=
ow:visible;font-size:12px;color:rgb(36,41,46);word-wrap:normal;white-space:=
pre">    <span class=3D"gmail-pl-c1" style=3D"box-sizing:border-box;color:r=
gb(0,92,197)">tracepoint</span>(librbd, discard_exit, -EINVAL);</td></tr><t=
r style=3D"box-sizing:border-box"><td id=3D"gmail-L4036" class=3D"gmail-blo=
b-num gmail-js-line-number" style=3D"font-family:SFMono-Regular,Consolas,&q=
uot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px;box-sizing:bor=
der-box;padding:0px 10px;width:50px;min-width:50px;font-size:12px;line-heig=
ht:20px;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;vertic=
al-align:top"></td><td id=3D"gmail-LC4036" class=3D"gmail-blob-code gmail-b=
lob-code-inner gmail-js-file-line" style=3D"font-family:SFMono-Regular,Cons=
olas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px;box-siz=
ing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;overflo=
w:visible;font-size:12px;color:rgb(36,41,46);word-wrap:normal;white-space:p=
re">    <span class=3D"gmail-pl-k" style=3D"box-sizing:border-box;color:rgb=
(215,58,73)">return</span> -EINVAL;</td></tr><tr style=3D"box-sizing:border=
-box"><td id=3D"gmail-L4037" class=3D"gmail-blob-num gmail-js-line-number" =
style=3D"font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Me=
nlo,Courier,monospace;margin:0px;box-sizing:border-box;padding:0px 10px;wid=
th:50px;min-width:50px;font-size:12px;line-height:20px;color:rgba(27,31,35,=
0.3);text-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D=
"gmail-LC4037" class=3D"gmail-blob-code gmail-blob-code-inner gmail-js-file=
-line" style=3D"font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&q=
uot;,Menlo,Courier,monospace;margin:0px;box-sizing:border-box;padding:0px 1=
0px;line-height:20px;vertical-align:top;overflow:visible;font-size:12px;col=
or:rgb(36,41,46);word-wrap:normal;white-space:pre">  }</td></tr><tr style=
=3D"box-sizing:border-box"><td id=3D"gmail-L4038" class=3D"gmail-blob-num g=
mail-js-line-number" style=3D"font-family:SFMono-Regular,Consolas,&quot;Lib=
eration Mono&quot;,Menlo,Courier,monospace;margin:0px;box-sizing:border-box=
;padding:0px 10px;width:50px;min-width:50px;font-size:12px;line-height:20px=
;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;vertical-alig=
n:top"></td><td id=3D"gmail-LC4038" class=3D"gmail-blob-code gmail-blob-cod=
e-inner gmail-js-file-line" style=3D"font-family:SFMono-Regular,Consolas,&q=
uot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px;box-sizing:bor=
der-box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visib=
le;font-size:12px;color:rgb(36,41,46);word-wrap:normal;white-space:pre">
</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L4039" class=
=3D"gmail-blob-num gmail-js-line-number" style=3D"font-family:SFMono-Regula=
r,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px;b=
ox-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;font-size:1=
2px;line-height:20px;color:rgba(27,31,35,0.3);text-align:right;white-space:=
nowrap;vertical-align:top"></td><td id=3D"gmail-LC4039" class=3D"gmail-blob=
-code gmail-blob-code-inner gmail-js-file-line" style=3D"font-family:SFMono=
-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;margi=
n:0px;box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-alig=
n:top;overflow:visible;font-size:12px;color:rgb(36,41,46);word-wrap:normal;=
white-space:pre">  <span class=3D"gmail-pl-k" style=3D"box-sizing:border-bo=
x;color:rgb(215,58,73)">int</span> r =3D ictx-&gt;<span class=3D"gmail-pl-s=
mi" style=3D"box-sizing:border-box;color:rgb(36,41,46)">io_work_queue</span=
>-&gt;<span class=3D"gmail-pl-c1" style=3D"box-sizing:border-box;color:rgb(=
0,92,197)">discard</span>(ofs, len, ictx-&gt;<span class=3D"gmail-pl-smi" s=
tyle=3D"box-sizing:border-box;color:rgb(36,41,46)">skip_partial_discard</sp=
an>);</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L4040" c=
lass=3D"gmail-blob-num gmail-js-line-number" style=3D"font-family:SFMono-Re=
gular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0=
px;box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;font-si=
ze:12px;line-height:20px;color:rgba(27,31,35,0.3);text-align:right;white-sp=
ace:nowrap;vertical-align:top"></td><td id=3D"gmail-LC4040" class=3D"gmail-=
blob-code gmail-blob-code-inner gmail-js-file-line" style=3D"font-family:SF=
Mono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;m=
argin:0px;box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-=
align:top;overflow:visible;font-size:12px;color:rgb(36,41,46);word-wrap:nor=
mal;white-space:pre">  <span class=3D"gmail-pl-c1" style=3D"box-sizing:bord=
er-box;color:rgb(0,92,197)">tracepoint</span>(librbd, discard_exit, r);</td=
></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L4041" class=3D"g=
mail-blob-num gmail-js-line-number" style=3D"font-family:SFMono-Regular,Con=
solas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px;box-si=
zing:border-box;padding:0px 10px;width:50px;min-width:50px;font-size:12px;l=
ine-height:20px;color:rgba(27,31,35,0.3);text-align:right;white-space:nowra=
p;vertical-align:top"></td><td id=3D"gmail-LC4041" class=3D"gmail-blob-code=
 gmail-blob-code-inner gmail-js-file-line" style=3D"font-family:SFMono-Regu=
lar,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;margin:0px=
;box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:top=
;overflow:visible;font-size:12px;color:rgb(36,41,46);word-wrap:normal;white=
-space:pre">  <span class=3D"gmail-pl-k" style=3D"box-sizing:border-box;col=
or:rgb(215,58,73)">return</span> r;</td></tr><tr style=3D"box-sizing:border=
-box"><td id=3D"gmail-L4042" class=3D"gmail-blob-num gmail-js-line-number" =
style=3D"font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Me=
nlo,Courier,monospace;margin:0px;box-sizing:border-box;padding:0px 10px;wid=
th:50px;min-width:50px;font-size:12px;line-height:20px;color:rgba(27,31,35,=
0.3);text-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D=
"gmail-LC4042" class=3D"gmail-blob-code gmail-blob-code-inner gmail-js-file=
-line" style=3D"font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&q=
uot;,Menlo,Courier,monospace;margin:0px;box-sizing:border-box;padding:0px 1=
0px;line-height:20px;vertical-align:top;overflow:visible;font-size:12px;col=
or:rgb(36,41,46);word-wrap:normal;white-space:pre">}</td></tr></tbody></tab=
le>
I tried to call rbd python api,  rbd.Image.discard , and I found there is l=
imit to the parameter len ,=20
 it is a uint64, but is limited by std::numeric_limits&lt;int&gt;::max(), s=
o that I can&#39;t discard=20
too large space at a time. So I  wonder what the considerations are about t=
his?</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L4030" cl=
ass=3D"gmail-blob-num gmail-js-line-number" style=3D"box-sizing:border-box;=
padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Conso=
las,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;line=
-height:20px;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;v=
ertical-align:top"></td><td id=3D"gmail-LC4030" class=3D"gmail-blob-code gm=
ail-blob-code-inner gmail-js-file-line" style=3D"box-sizing:border-box;padd=
ing:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font-fami=
ly:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monosp=
ace;font-size:12px;color:rgb(36,41,46);word-wrap:normal;white-space:pre"><b=
r></td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L4043" clas=
s=3D"gmail-blob-num gmail-js-line-number" style=3D"box-sizing:border-box;pa=
dding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consola=
s,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;line-h=
eight:20px;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;ver=
tical-align:top"></td></tr></tbody></table><br class=3D"gmail-Apple-interch=
ange-newline">

<br></div>

--0000000000009aa61a0572bef177--

--===============3151090648641297227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3151090648641297227==--
