From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RBD behavior for reads to a volume with no data
	written
Date: Tue, 2 May 2017 14:29:04 -0400
Message-ID: <CA+aFP1BHZfSXJ9J09khYEX4NBpRO=EQaSX_7S1qPunX5iv1xcA@mail.gmail.com>
References: <CAAD08TBLF3TWP=JaXrq05D-5CZhtf79ahg-ooxao3AzR+7_ARg@mail.gmail.com>
	<CAAD08TC_-mPpGOFipgxpPbftFNyhCEMq+1uu3Mf7c0D3TZWTJA@mail.gmail.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1736437258=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAD08TC_-mPpGOFipgxpPbftFNyhCEMq+1uu3Mf7c0D3TZWTJA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Prashant Murthy <pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1736437258==
Content-Type: multipart/alternative; boundary=94eb2c1a2336ef2f14054e8eb68d

--94eb2c1a2336ef2f14054e8eb68d
Content-Type: text/plain; charset=UTF-8

If the RBD object map feature is enabled, the read request would never even
be sent to the OSD if the client knows the backing object doesn't exist.
However, if the object map feature is disabled, the read request will be
sent to the OSD.

The OSD isn't my area of expertise, but I can try to explain what occurs to
the best of my knowledge. There is a small in-memory cache for object
contexts with the OSD PG -- which includes a whiteout flag to indicate the
object is deleted. I believe that the whiteout flag is only really used on
a cache tier to avoid having to attempt to promote a known non-existent
object. Therefore, in the common case the OSD would query the non-existent
object from the object store (FileStore or BlueStore).

In FileStore, it will attempt to open the associated backing file for
object. If the necessary dentries are cached in the kernel, I'd expect that
the -ENOENT error would be bubbled back to RBD w/o a disk hit. Otherwise,
the kernel would need to read the associated dentries from disk to
determine that the object is missing.

In BlueStore, there is another in-memory cache for onodes that can quickly
detect a missing object. If the object isn't in the cache, the associated
onode will be looked up within the backing RocksDB. If the RocksDB metadata
scan for the object's onode fails since the object is missing, the -ENOENT
error would be bubbled back to the client.



On Tue, May 2, 2017 at 1:24 PM, Prashant Murthy <pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
wrote:

> I wanted to add that I was particularly interested about the behavior with
> filestore, but was also curious how this works on bluestore.
>
> Prashant
>
> On Mon, May 1, 2017 at 10:04 PM, Prashant Murthy <pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
> wrote:
>
>> Hi all,
>>
>> I was wondering what happens when reads are issued to an RBD device with
>> no previously written data. Can somebody explain how such requests flow
>> from rbd (client) into OSDs and whether any of these reads would hit the
>> disks at all or whether OSD metadata would recognize that there is no data
>> at the offsets requested and returns a bunch of zeros back to the client?
>>
>> Thanks,
>> Prashant
>>
>> --
>> Prashant Murthy
>> Sr Director, Software Engineering | Salesforce
>> Mobile: 919-961-3041 <(919)%20961-3041>
>>
>>
>> --
>>
>
>
>
> --
> Prashant Murthy
> Sr Director, Software Engineering | Salesforce
> Mobile: 919-961-3041 <(919)%20961-3041>
>
>
> --
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>


-- 
Jason

--94eb2c1a2336ef2f14054e8eb68d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">If the RBD object map feature is enabled, the read request=
 would never even be sent to the OSD if the client knows the backing object=
 doesn&#39;t exist. However, if the object map feature is disabled, the rea=
d request will be sent to the OSD.<div><br></div><div>The OSD isn&#39;t my =
area of expertise, but I can try to explain what occurs to the best of my k=
nowledge. There is a small in-memory cache for object contexts with the OSD=
 PG -- which includes a whiteout flag to indicate the object is deleted. I =
believe that the whiteout flag is only really used on a cache tier to avoid=
 having to attempt to promote a known non-existent object. Therefore, in th=
e common case the OSD would query the non-existent object from the object s=
tore (FileStore or BlueStore).</div><div><br></div><div>In FileStore, it wi=
ll attempt to open the associated backing file for object. If the necessary=
 dentries are cached in the kernel, I&#39;d expect that the -ENOENT error w=
ould be bubbled back to RBD w/o a disk hit. Otherwise, the kernel would nee=
d to read the associated dentries from disk to determine that the object is=
 missing.</div><div><br></div><div>In BlueStore, there is another in-memory=
 cache for onodes that can quickly detect a missing object. If the object i=
sn&#39;t in the cache, the associated onode will be looked up within the ba=
cking RocksDB. If the RocksDB=C2=A0metadata scan for the object&#39;s onode=
 fails since the object is missing, the -ENOENT error would be bubbled back=
 to the client.</div><div><br></div><div><br></div></div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Tue, May 2, 2017 at 1:24 PM, Pra=
shant Murthy <span dir=3D"ltr">&lt;<a href=3D"mailto:pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org=
" target=3D"_blank">pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div dir=3D"ltr">I wanted to add that I was particu=
larly interested about the behavior with filestore, but was also curious ho=
w this works on bluestore. =C2=A0<span class=3D"HOEnZb"><font color=3D"#888=
888"><div><br></div><div>Prashant</div></font></span><div><div class=3D"h5"=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, May 1, 2=
017 at 10:04 PM, Prashant Murthy <span dir=3D"ltr">&lt;<a href=3D"mailto:pm=
urthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org" target=3D"_blank">pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi all,=C2=A0<=
div><br></div><div>I was wondering what happens when reads are issued to an=
 RBD device with no previously written data. Can somebody explain how such =
requests flow from rbd (client) into OSDs and whether any of these reads wo=
uld hit the disks at all or whether OSD metadata would recognize that there=
 is no data at the offsets requested and returns a bunch of zeros back to t=
he client? =C2=A0</div><div><br></div><div>Thanks,</div><div>Prashant</div>=
<span class=3D"m_7572817927168280927m_5116591711045347817HOEnZb"><font colo=
r=3D"#888888"><div><div><br></div>-- <br><div class=3D"m_757281792716828092=
7m_5116591711045347817m_-644972376694415374gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div>Prashant Murthy<br></div>Sr Director, S=
oftware Engineering | Salesforce<br>Mobile: <a href=3D"tel:(919)%20961-3041=
" value=3D"+19199613041" target=3D"_blank">919-961-3041</a></div><div dir=
=3D"ltr"><br></div><div><img src=3D"http://www.salesforce.com/common/assets=
/images/email/salesforce-email-signature.png" width=3D"200" height=3D"46"><=
br><font color=3D"#ffffff">--</font></div></div></div></div></div></div></d=
iv></div>
</div></font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"m_7572817927168280927m_5116591711045347817gmail_signature" data-smartma=
il=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div>Prashant Murthy<br></div>Sr Director, S=
oftware Engineering | Salesforce<br>Mobile: <a href=3D"tel:(919)%20961-3041=
" value=3D"+19199613041" target=3D"_blank">919-961-3041</a></div><div dir=
=3D"ltr"><br></div><div><img src=3D"http://www.salesforce.com/common/assets=
/images/email/salesforce-email-signature.png" width=3D"200" height=3D"46"><=
br><font color=3D"#ffffff">--</font></div></div></div></div></div></div></d=
iv></div>
</div></div></div></div>
<br>______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div>Jason</div></div></div></div></div></div>
</div>

--94eb2c1a2336ef2f14054e8eb68d--

--===============1736437258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1736437258==--
