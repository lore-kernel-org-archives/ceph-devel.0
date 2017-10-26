From: Haomai Wang <haomai-p1s0O0zx/60@public.gmane.org>
Subject: Re: ceph zstd not for bluestor due to performance
 reasons
Date: Thu, 26 Oct 2017 06:44:25 +0000
Message-ID: <CACJqLyYsJ8WeWOdu4M2K7bnCbQ=fh8jQ=MP=msa64jo5=fic0w@mail.gmail.com>
References: <BD0427BB-F720-4746-82F9-E082D2396F56@profihost.ag>
 <alpine.DEB.2.11.1710251940520.22592@piezo.us.to>
 <5cf6f721-05ea-4e38-a6b9-04cff5d6aad3@profihost.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1745194595502180474=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5cf6f721-05ea-4e38-a6b9-04cff5d6aad3-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1745194595502180474==
Content-Type: multipart/alternative; boundary="001a114e2a626ee24f055c6d8104"

--001a114e2a626ee24f055c6d8104
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>=E4=BA=8E2017=E5=B9=B41=
0=E6=9C=8826=E6=97=A5 =E5=91=A8=E5=9B=9B17:06=E5=86=99=E9=81=93=EF=BC=9A

> Hi Sage,
>
> Am 25.10.2017 um 21:54 schrieb Sage Weil:
> > On Wed, 25 Oct 2017, Stefan Priebe - Profihost AG wrote:
> >> Hello,
> >>
> >> in the lumious release notes is stated that zstd is not supported by
> >> bluestor due to performance reason. I'm wondering why btrfs instead
> >> states that zstd is as fast as lz4 but compresses as good as zlib.
> >>
> >> Why is zlib than supported by bluestor? And why does btrfs / facebook
> >> behave different?
> >>
> >> "BlueStore supports inline compression using zlib, snappy, or LZ4. (Ce=
ph
> >> also supports zstd for RGW compression but zstd is not recommended for
> >> BlueStore for performance reasons.)"
> >
> > zstd will work but in our testing the performance wasn't great for
> > bluestore in particular.  The problem was that for each compression run
> > there is a relatively high start-up cost initializing the zstd
> > context/state (IIRC a memset of a huge memory buffer) that dominated th=
e
> > execution time... primarily because bluestore is generally compressing
> > pretty small chunks of data at a time, not big buffers or streams.
> >
> > Take a look at unittest_compression timings on compressing 16KB buffers
> > (smaller than bluestore needs usually, but illustrated of the problem):
> >
> > [ RUN      ] Compressor/CompressorTest.compress_16384/0
> > [plugin zlib (zlib/isal)]
> > [       OK ] Compressor/CompressorTest.compress_16384/0 (294 ms)
> > [ RUN      ] Compressor/CompressorTest.compress_16384/1
> > [plugin zlib (zlib/noisal)]
> > [       OK ] Compressor/CompressorTest.compress_16384/1 (1755 ms)
> > [ RUN      ] Compressor/CompressorTest.compress_16384/2
> > [plugin snappy (sna
> <https://maps.google.com/?q=3Dy+(sna&entry=3Dgmail&source=3Dg>ppy)]
> > [       OK ] Compressor/CompressorTest.compress_16384/2 (169 ms)
> > [ RUN      ] Compressor/CompressorTest.compress_16384/3
> > [plugin zstd (zstd)]
> > [       OK ] Compressor/CompressorTest.compress_16384/3 (4528 ms)
> >
> > It's an order of magnitude slower than zlib or snappy, which probably
> > isn't acceptable--even if it is a bit smaller.
> >
> > We just updated to a newer zstd the other day but I haven't been paying
> > attention to the zstd code changes.  When I was working on this the
> plugin
> > was initially also misusing the zstd API, but it was also pointed out
> > that the size of the memset is dependent on the compression level.
> > Maybe a different (default) choice there woudl help.
> >
> > https://github.com/facebook/zstd/issues/408#issuecomment-252163241
>
> thanks for the fast reply. Btrfs uses a default compression level of 3
> but i think this is the default anyway.
>
> Does the zstd plugin of ceph already uses the mentioned
> ZSTD_resetCStream instead of creating and initializing a new one every
> time?
>
> So if performance matters ceph would recommand snappy?
>


in our test, lz4 is better than snappy

>
> Greets,
> Stefan
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a114e2a626ee24f055c6d8104
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote"><div dir=3D"auto">Stefan Priebe - Profi=
host AG &lt;<a href=3D"mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org<=
/a>&gt;=E4=BA=8E2017=E5=B9=B410=E6=9C=8826=E6=97=A5 =E5=91=A8=E5=9B=9B17:06=
=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Sage=
,<br>
<br>
Am 25.10.2017 um 21:54 schrieb Sage Weil:<br>
&gt; On Wed, 25 Oct 2017, Stefan Priebe - Profihost AG wrote:<br>
&gt;&gt; Hello,<br>
&gt;&gt;<br>
&gt;&gt; in the lumious release notes is stated that zstd is not supported =
by<br>
&gt;&gt; bluestor due to performance reason. I&#39;m wondering why btrfs in=
stead<br>
&gt;&gt; states that zstd is as fast as lz4 but compresses as good as zlib.=
<br>
&gt;&gt;<br>
&gt;&gt; Why is zlib than supported by bluestor? And why does btrfs / faceb=
ook<br>
&gt;&gt; behave different?<br>
&gt;&gt;<br>
&gt;&gt; &quot;BlueStore supports inline compression using zlib, snappy, or=
 LZ4. (Ceph<br>
&gt;&gt; also supports zstd for RGW compression but zstd is not recommended=
 for<br>
&gt;&gt; BlueStore for performance reasons.)&quot;<br>
&gt;<br>
&gt; zstd will work but in our testing the performance wasn&#39;t great for=
<br>
&gt; bluestore in particular.=C2=A0 The problem was that for each compressi=
on run<br>
&gt; there is a relatively high start-up cost initializing the zstd<br>
&gt; context/state (IIRC a memset of a huge memory buffer) that dominated t=
he<br>
&gt; execution time... primarily because bluestore is generally compressing=
<br>
&gt; pretty small chunks of data at a time, not big buffers or streams.<br>
&gt;<br>
&gt; Take a look at unittest_compression timings on compressing 16KB buffer=
s<br>
&gt; (smaller than bluestore needs usually, but illustrated of the problem)=
:<br>
&gt;<br>
&gt; [ RUN=C2=A0 =C2=A0 =C2=A0 ] Compressor/CompressorTest.compress_16384/0=
<br>
&gt; [plugin zlib (zlib/isal)]<br>
&gt; [=C2=A0 =C2=A0 =C2=A0 =C2=A0OK ] Compressor/CompressorTest.compress_16=
384/0 (294 ms)<br>
&gt; [ RUN=C2=A0 =C2=A0 =C2=A0 ] Compressor/CompressorTest.compress_16384/1=
<br>
&gt; [plugin zlib (zlib/noisal)]<br>
&gt; [=C2=A0 =C2=A0 =C2=A0 =C2=A0OK ] Compressor/CompressorTest.compress_16=
384/1 (1755 ms)<br>
&gt; [ RUN=C2=A0 =C2=A0 =C2=A0 ] Compressor/CompressorTest.compress_16384/2=
<br>
&gt; [plugin snapp<a href=3D"https://maps.google.com/?q=3Dy+(sna&amp;entry=
=3Dgmail&amp;source=3Dg">y (sna</a>ppy)]<br>
&gt; [=C2=A0 =C2=A0 =C2=A0 =C2=A0OK ] Compressor/CompressorTest.compress_16=
384/2 (169 ms)<br>
&gt; [ RUN=C2=A0 =C2=A0 =C2=A0 ] Compressor/CompressorTest.compress_16384/3=
<br>
&gt; [plugin zstd (zstd)]<br>
&gt; [=C2=A0 =C2=A0 =C2=A0 =C2=A0OK ] Compressor/CompressorTest.compress_16=
384/3 (4528 ms)<br>
&gt;<br>
&gt; It&#39;s an order of magnitude slower than zlib or snappy, which proba=
bly<br>
&gt; isn&#39;t acceptable--even if it is a bit smaller.<br>
&gt;<br>
&gt; We just updated to a newer zstd the other day but I haven&#39;t been p=
aying<br>
&gt; attention to the zstd code changes.=C2=A0 When I was working on this t=
he plugin<br>
&gt; was initially also misusing the zstd API, but it was also pointed out<=
br>
&gt; that the size of the memset is dependent on the compression level.<br>
&gt; Maybe a different (default) choice there woudl help.<br>
&gt;<br>
&gt; <a href=3D"https://github.com/facebook/zstd/issues/408#issuecomment-25=
2163241" rel=3D"noreferrer" target=3D"_blank">https://github.com/facebook/z=
std/issues/408#issuecomment-252163241</a><br>
<br>
thanks for the fast reply. Btrfs uses a default compression level of 3<br>
but i think this is the default anyway.<br>
<br>
Does the zstd plugin of ceph already uses the mentioned<br>
ZSTD_resetCStream instead of creating and initializing a new one every time=
?<br>
<br>
So if performance matters ceph would recommand snappy?<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">in our test, lz4 is better than snappy</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
Greets,<br>
Stefan<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div></div>

--001a114e2a626ee24f055c6d8104--

--===============1745194595502180474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1745194595502180474==--
