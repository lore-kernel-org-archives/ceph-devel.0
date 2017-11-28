From: Maged Mokhtar <mmokhtar-6jkX1og9WkpAfugRpC6u6w@public.gmane.org>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 14:20:33 +0200
Message-ID: <58d2cc9068a226ef269faac3597a19d3@petasan.org>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <1821337488.5487.1511856776936@ox.pcextreme.nl>
 <CAC-Np1zfMoqtW2M75ZAys1_NTEkns6MJ6HimuRR3nFhbMVzjPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6173976105064339000=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1zfMoqtW2M75ZAys1_NTEkns6MJ6HimuRR3nFhbMVzjPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6173976105064339000==
Content-Type: multipart/alternative;
 boundary="=_33aa7341a4a5b2bc03c97e26fcb77bed"

--=_33aa7341a4a5b2bc03c97e26fcb77bed
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

I tend to agree with Wido. May of us still reply on ceph-disk and hope
to see it live a little longer. 

Maged 

On 2017-11-28 13:54, Alfredo Deza wrote:

> On Tue, Nov 28, 2017 at 3:12 AM, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org> wrote: 
> Op 27 november 2017 om 14:36 schreef Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> 
> For the upcoming Luminous release (12.2.2), ceph-disk will be
> officially in 'deprecated' mode (bug fixes only). A large banner with
> deprecation information has been added, which will try to raise
> awareness.
> 
> As much as I like ceph-volume and the work being done, is it really a good idea to use a minor release to deprecate a tool?
> 
> Can't we just introduce ceph-volume and deprecate ceph-disk at the release of M? Because when you upgrade to 12.2.2 suddenly existing integrations will have deprecation warnings being thrown at them while they haven't upgraded to a new major version.

ceph-volume has been present since the very first release of Luminous,
the deprecation warning in ceph-disk is the only "new" thing
introduced for 12.2.2.

> As ceph-deploy doesn't support ceph-disk either I don't think it's a good idea to deprecate it right now.

ceph-deploy work is being done to support ceph-volume exclusively
(ceph-disk support is dropped fully), which will mean a change in its
API in a non-backwards compatible
way. A major version change in ceph-deploy, documentation, and a bunch
of documentation is being worked on to allow users to transition to
it.

> How do others feel about this?
> 
> Wido
> 
>> We are strongly suggesting using ceph-volume for new (and old) OSD
>> deployments. The only current exceptions to this are encrypted OSDs
>> and FreeBSD systems
>> 
>> Encryption support is planned and will be coming soon to ceph-volume.
>> 
>> A few items to consider:
>> 
>> * ceph-disk is expected to be fully removed by the Mimic release
>> * Existing OSDs are supported by ceph-volume. They can be "taken over" [0 [1]]
>> * ceph-ansible already fully supports ceph-volume and will soon default to it
>> * ceph-deploy support is planned and should be fully implemented soon
>> 
>> [0] http://docs.ceph.com/docs/master/ceph-volume/simple/
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
 _______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com 

 

Links:
------
[1] http://docs.ceph.com/docs/master/ceph-volume/simple/
--=_33aa7341a4a5b2bc03c97e26fcb77bed
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8" /></head><body style=3D'font-size: 10pt; font-family: Verdana,Gen=
eva,sans-serif'>
<p>I tend to agree with Wido. May of us still reply on ceph-disk and hope t=
o see it live a little longer.</p>
<p>Maged</p>
<p><br /></p>
<p>On 2017-11-28 13:54, Alfredo Deza wrote:</p>
<blockquote type=3D"cite" style=3D"padding: 0 0.4em; border-left: #1010ff 2=
px solid; margin: 0"><!-- html ignored --><!-- head ignored --><!-- meta ig=
nored -->
<div class=3D"pre" style=3D"margin: 0; padding: 0; font-family: monospace">=
On Tue, Nov 28, 2017 at 3:12 AM, Wido den Hollander &lt;<a href=3D"mailto:w=
ido-fspyXLx8qC4@public.gmane.org" rel=3D"noreferrer">wido-fspyXLx8qC4@public.gmane.org</a>&gt; wrote:
<blockquote type=3D"cite" style=3D"padding: 0 0.4em; border-left: #1010ff 2=
px solid; margin: 0"><br />
<blockquote type=3D"cite" style=3D"padding: 0 0.4em; border-left: #1010ff 2=
px solid; margin: 0">Op 27 november 2017 om 14:36 schreef Alfredo Deza &lt;=
<a href=3D"mailto:adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" rel=3D"noreferrer">adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>=
&gt;:<br /><br /><br /> For the upcoming Luminous release (12.2.2), ceph-di=
sk will be<br /> officially in 'deprecated' mode (bug fixes only). A large =
banner with<br /> deprecation information has been added, which will try to=
 raise<br /> awareness.<br /><br /></blockquote>
<br /> As much as I like ceph-volume and the work being done, is it really =
a good idea to use a minor release to deprecate a tool?<br /><br /> Can't w=
e just introduce ceph-volume and deprecate ceph-disk at the release of M? B=
ecause when you upgrade to 12.2.2 suddenly existing integrations will have =
deprecation warnings being thrown at them while they haven't upgraded to a =
new major version.</blockquote>
<br /> ceph-volume has been present since the very first release of Luminou=
s,<br /> the deprecation warning in ceph-disk is the only "new" thing<br />=
 introduced for 12.2.2.<br /><br />
<blockquote type=3D"cite" style=3D"padding: 0 0.4em; border-left: #1010ff 2=
px solid; margin: 0"><br /> As ceph-deploy doesn't support ceph-disk either=
 I don't think it's a good idea to deprecate it right now.</blockquote>
<br /> ceph-deploy work is being done to support ceph-volume exclusively<br=
 /> (ceph-disk support is dropped fully), which will mean a change in its<b=
r /> API in a non-backwards compatible<br /> way. A major version change in=
 ceph-deploy, documentation, and a bunch<br /> of documentation is being wo=
rked on to allow users to transition to<br /> it.<br /><br />
<blockquote type=3D"cite" style=3D"padding: 0 0.4em; border-left: #1010ff 2=
px solid; margin: 0"><br /> How do others feel about this?<br /><br /> Wido=
<br /><br />
<blockquote type=3D"cite" style=3D"padding: 0 0.4em; border-left: #1010ff 2=
px solid; margin: 0">We are strongly suggesting using ceph-volume for new (=
and old) OSD<br /> deployments. The only current exceptions to this are enc=
rypted OSDs<br /> and FreeBSD systems<br /><br /> Encryption support is pla=
nned and will be coming soon to ceph-volume.<br /><br /> A few items to con=
sider:<br /><br /> * ceph-disk is expected to be fully removed by the Mimic=
 release<br /> * Existing OSDs are supported by ceph-volume. They can be "t=
aken over" [<a href=3D"http://docs.ceph.com/docs/master/ceph-volume/simple/=
" target=3D"_blank" rel=3D"noreferrer">0</a>]<br /> * ceph-ansible already =
fully supports ceph-volume and will soon default to it<br /> * ceph-deploy =
support is planned and should be fully implemented soon<br /><br /><br /> [=
0] <a href=3D"http://docs.ceph.com/docs/master/ceph-volume/simple/" target=
=3D"_blank" rel=3D"noreferrer">http://docs.ceph.com/docs/master/ceph-volume=
/simple/</a><br /> _______________________________________________<br /> ce=
ph-users mailing list<br /><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" rel=
=3D"noreferrer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br /><a href=3D"http://lists=
=2Eceph.com/listinfo.cgi/ceph-users-ceph.com" target=3D"_blank" rel=3D"nore=
ferrer">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a></blockqu=
ote>
</blockquote>
_______________________________________________<br /> ceph-users mailing li=
st<br /><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" rel=3D"noreferrer">cep=
h-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br /><a href=3D"http://lists.ceph.com/listinfo=
=2Ecgi/ceph-users-ceph.com" target=3D"_blank" rel=3D"noreferrer">http://lis=
ts.ceph.com/listinfo.cgi/ceph-users-ceph.com</a></div>
</blockquote>
<p><br /></p>

</body></html>

--=_33aa7341a4a5b2bc03c97e26fcb77bed--

--===============6173976105064339000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6173976105064339000==--
