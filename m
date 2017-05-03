From: Prashant Murthy <pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
Subject: Re: RBD behavior for reads to a volume with no data
	written
Date: Wed, 3 May 2017 12:04:44 -0700
Message-ID: <CAAD08TCqudGWaQ9tP_OSARrzMVhxtjQrZ9FU_xLT9pXE5+kLUQ@mail.gmail.com>
References: <CAAD08TBLF3TWP=JaXrq05D-5CZhtf79ahg-ooxao3AzR+7_ARg@mail.gmail.com>
	<CAAD08TC_-mPpGOFipgxpPbftFNyhCEMq+1uu3Mf7c0D3TZWTJA@mail.gmail.com>
	<CA+aFP1BHZfSXJ9J09khYEX4NBpRO=EQaSX_7S1qPunX5iv1xcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1338417663=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+aFP1BHZfSXJ9J09khYEX4NBpRO=EQaSX_7S1qPunX5iv1xcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1338417663==
Content-Type: multipart/alternative; boundary=001a113cd70a4b219a054ea354a0

--001a113cd70a4b219a054ea354a0
Content-Type: text/plain; charset=UTF-8

Thanks for the detailed explanation, Jason. It makes sense that such
operations would end up being a few metadata lookups only (and the metadata
lookups will hit the disk only if they are not cached in-memory).

Prashant

On Tue, May 2, 2017 at 11:29 AM, Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> If the RBD object map feature is enabled, the read request would never
> even be sent to the OSD if the client knows the backing object doesn't
> exist. However, if the object map feature is disabled, the read request
> will be sent to the OSD.
>
> The OSD isn't my area of expertise, but I can try to explain what occurs
> to the best of my knowledge. There is a small in-memory cache for object
> contexts with the OSD PG -- which includes a whiteout flag to indicate the
> object is deleted. I believe that the whiteout flag is only really used on
> a cache tier to avoid having to attempt to promote a known non-existent
> object. Therefore, in the common case the OSD would query the non-existent
> object from the object store (FileStore or BlueStore).
>
> In FileStore, it will attempt to open the associated backing file for
> object. If the necessary dentries are cached in the kernel, I'd expect that
> the -ENOENT error would be bubbled back to RBD w/o a disk hit. Otherwise,
> the kernel would need to read the associated dentries from disk to
> determine that the object is missing.
>
> In BlueStore, there is another in-memory cache for onodes that can quickly
> detect a missing object. If the object isn't in the cache, the associated
> onode will be looked up within the backing RocksDB. If the RocksDB metadata
> scan for the object's onode fails since the object is missing, the -ENOENT
> error would be bubbled back to the client.
>
>
>
> On Tue, May 2, 2017 at 1:24 PM, Prashant Murthy <pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
> wrote:
>
>> I wanted to add that I was particularly interested about the behavior
>> with filestore, but was also curious how this works on bluestore.
>>
>> Prashant
>>
>> On Mon, May 1, 2017 at 10:04 PM, Prashant Murthy <pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
>> wrote:
>>
>>> Hi all,
>>>
>>> I was wondering what happens when reads are issued to an RBD device with
>>> no previously written data. Can somebody explain how such requests flow
>>> from rbd (client) into OSDs and whether any of these reads would hit the
>>> disks at all or whether OSD metadata would recognize that there is no data
>>> at the offsets requested and returns a bunch of zeros back to the client?
>>>
>>> Thanks,
>>> Prashant
>>>
>>> --
>>> Prashant Murthy
>>> Sr Director, Software Engineering | Salesforce
>>> Mobile: 919-961-3041 <(919)%20961-3041>
>>>
>>>
>>> --
>>>
>>
>>
>>
>> --
>> Prashant Murthy
>> Sr Director, Software Engineering | Salesforce
>> Mobile: 919-961-3041 <(919)%20961-3041>
>>
>>
>> --
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>
>
> --
> Jason
>



-- 
Prashant Murthy
Sr Director, Software Engineering | Salesforce
Mobile: 919-961-3041


--

--001a113cd70a4b219a054ea354a0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the detailed explanation, Jason. It makes sense=
 that such operations would end up being a few metadata lookups only (and t=
he metadata lookups will hit the disk only if they are not cached in-memory=
).=C2=A0<div><br></div><div>Prashant</div></div><div class=3D"gmail_extra">=
<br><div class=3D"gmail_quote">On Tue, May 2, 2017 at 11:29 AM, Jason Dilla=
man <span dir=3D"ltr">&lt;<a href=3D"mailto:jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"=
_blank">jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div dir=3D"ltr">If the RBD object map feature is enabled, the rea=
d request would never even be sent to the OSD if the client knows the backi=
ng object doesn&#39;t exist. However, if the object map feature is disabled=
, the read request will be sent to the OSD.<div><br></div><div>The OSD isn&=
#39;t my area of expertise, but I can try to explain what occurs to the bes=
t of my knowledge. There is a small in-memory cache for object contexts wit=
h the OSD PG -- which includes a whiteout flag to indicate the object is de=
leted. I believe that the whiteout flag is only really used on a cache tier=
 to avoid having to attempt to promote a known non-existent object. Therefo=
re, in the common case the OSD would query the non-existent object from the=
 object store (FileStore or BlueStore).</div><div><br></div><div>In FileSto=
re, it will attempt to open the associated backing file for object. If the =
necessary dentries are cached in the kernel, I&#39;d expect that the -ENOEN=
T error would be bubbled back to RBD w/o a disk hit. Otherwise, the kernel =
would need to read the associated dentries from disk to determine that the =
object is missing.</div><div><br></div><div>In BlueStore, there is another =
in-memory cache for onodes that can quickly detect a missing object. If the=
 object isn&#39;t in the cache, the associated onode will be looked up with=
in the backing RocksDB. If the RocksDB=C2=A0metadata scan for the object&#3=
9;s onode fails since the object is missing, the -ENOENT error would be bub=
bled back to the client.</div><div><br></div><div><br></div></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div class=3D"h5">On =
Tue, May 2, 2017 at 1:24 PM, Prashant Murthy <span dir=3D"ltr">&lt;<a href=
=3D"mailto:pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org" target=3D"_blank">pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org=
</a>&gt;</span> wrote:<br></div></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><=
div class=3D"h5"><div dir=3D"ltr">I wanted to add that I was particularly i=
nterested about the behavior with filestore, but was also curious how this =
works on bluestore. =C2=A0<span class=3D"m_3319729062071957250HOEnZb"><font=
 color=3D"#888888"><div><br></div><div>Prashant</div></font></span><div><di=
v class=3D"m_3319729062071957250h5"><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Mon, May 1, 2017 at 10:04 PM, Prashant Murthy <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org" target=3D"_blank">=
pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr">Hi all,=C2=A0<div><br></div><div>I was wondering what =
happens when reads are issued to an RBD device with no previously written d=
ata. Can somebody explain how such requests flow from rbd (client) into OSD=
s and whether any of these reads would hit the disks at all or whether OSD =
metadata would recognize that there is no data at the offsets requested and=
 returns a bunch of zeros back to the client? =C2=A0</div><div><br></div><d=
iv>Thanks,</div><div>Prashant</div><span class=3D"m_3319729062071957250m_75=
72817927168280927m_5116591711045347817HOEnZb"><font color=3D"#888888"><div>=
<div><br></div>-- <br><div class=3D"m_3319729062071957250m_7572817927168280=
927m_5116591711045347817m_-644972376694415374gmail_signature" data-smartmai=
l=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div>Prashant Murthy<br></div>Sr Director, S=
oftware Engineering | Salesforce<br>Mobile: <a href=3D"tel:(919)%20961-3041=
" value=3D"+19199613041" target=3D"_blank">919-961-3041</a></div><div dir=
=3D"ltr"><br></div><div><img src=3D"http://www.salesforce.com/common/assets=
/images/email/salesforce-email-signature.png" width=3D"200" height=3D"46"><=
br><font color=3D"#ffffff">--</font></div></div></div></div></div></div></d=
iv></div>
</div></font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"m_3319729062071957250m_7572817927168280927m_5116591711045347817gmail_si=
gnature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Prashant Murthy<b=
r></div>Sr Director, Software Engineering | Salesforce<br>Mobile: <a href=
=3D"tel:(919)%20961-3041" value=3D"+19199613041" target=3D"_blank">919-961-=
3041</a></div><div dir=3D"ltr"><br></div><div><img src=3D"http://www.salesf=
orce.com/common/assets/images/email/salesforce-email-signature.png" width=
=3D"200" height=3D"46"><br><font color=3D"#ffffff">--</font></div></div></d=
iv></div></div></div></div></div>
</div></div></div></div>
<br></div></div>______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
<br></blockquote></div><span class=3D"HOEnZb"><font color=3D"#888888"><br><=
br clear=3D"all"><div><br></div>-- <br><div class=3D"m_3319729062071957250g=
mail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><d=
iv dir=3D"ltr"><div><div>Jason</div></div></div></div></div></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Prasha=
nt Murthy<br></div>Sr Director, Software Engineering | Salesforce<br>Mobile=
: 919-961-3041</div><div dir=3D"ltr"><br></div><div><img src=3D"http://www.=
salesforce.com/common/assets/images/email/salesforce-email-signature.png" w=
idth=3D"200" height=3D"46"><br><font color=3D"#ffffff">--</font></div></div=
></div></div></div></div></div></div>
</div>

--001a113cd70a4b219a054ea354a0--

--===============1338417663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1338417663==--
