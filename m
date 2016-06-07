From: Corentin Bonneton <list-Ir4F46R2WEs@public.gmane.org>
Subject: Re: un-even data filled on OSDs
Date: Tue, 7 Jun 2016 15:52:38 +0200
Message-ID: <1F4849EF-DC23-468C-9008-7F1CCEE50F36@titin.fr>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
	<alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com>
	<CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>
	<alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com>
	<CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
	<alpine.DEB.2.11.1606070921430.6221@cpach.fuggernut.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============1161597136=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1606070921430.6221-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1161597136==
Content-Type: multipart/alternative; boundary="Apple-Mail=_3ED17459-A8FA-488B-A0E2-B45D95902F9A"


--Apple-Mail=_3ED17459-A8FA-488B-A0E2-B45D95902F9A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,
You how much your PG pools since he first saw you have left too big.

--
Cordialement,
Corentin BONNETON


> Le 7 juin 2016 =C3=A0 15:21, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> a =C3=A9crit =
:
>=20
> On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>> OK, understood...
>> To fix the nearfull warn, I am reducing the weight of a specific OSD,
>> which filled >85%..
>> Is this work-around advisable?
>=20
> Sure.  This is what reweight-by-utilization does for you, but=20
> automatically.
>=20
> sage
>=20
>>=20
>> Thanks
>> Swami
>>=20
>> On Tue, Jun 7, 2016 at 6:37 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
>>> On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>>>> Hi Sage,
>>>>> Jewel and the latest hammer point release have an improved
>>>>> reweight-by-utilization (ceph osd test-reweight-by-utilization ... =
to dry
>>>>> run) to correct this.
>>>>=20
>>>> Thank you....But not planning to upgrade the cluster soon.
>>>> So, in this case - are there any tunable options will help? like
>>>> "crush tunable optimal" or so?
>>>> OR any other configuration options change will help?
>>>=20
>>> Firefly also has reweight-by-utilization... it's just a bit less =
friendly
>>> than the newer versions.  CRUSH tunables don't generally help here =
unless
>>> you have lots of OSDs that are down+out.
>>>=20
>>> Note that firefly is no longer supported.
>>>=20
>>> sage
>>>=20
>>>=20
>>>>=20
>>>>=20
>>>> Thanks
>>>> Swami
>>>>=20
>>>>=20
>>>> On Tue, Jun 7, 2016 at 6:00 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> =
wrote:
>>>>> On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>>>>>> Hello,
>>>>>> I have aorund 100 OSDs in my ceph cluster. In this a few OSDs =
filled
>>>>>> with >85% of data and few OSDs filled with ~60%-70% of data.
>>>>>>=20
>>>>>> Any reason why the unevenly OSDs filling happned? do I need to =
any
>>>>>> tweaks on configuration to fix the above? Please advise.
>>>>>>=20
>>>>>> PS: Ceph version is - 0.80.7
>>>>>=20
>>>>> Jewel and the latest hammer point release have an improved
>>>>> reweight-by-utilization (ceph osd test-reweight-by-utilization ... =
to dry
>>>>> run) to correct this.
>>>>>=20
>>>>> sage
>>>>>=20
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>=20
>>>>=20
>>=20
>>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_3ED17459-A8FA-488B-A0E2-B45D95902F9A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D"">Hello,</div><div class=3D"">You how much your =
PG pools since he first saw you have left too big.</div><div =
class=3D""><br class=3D""></div><div class=3D"">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D"">--</div><div class=3D"">Cordialement,</div><div=
 class=3D"">Corentin BONNETON</div><div class=3D""><br =
class=3D""></div></div></div></div>
</div>
<br class=3D""><div style=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">Le 7 juin 2016 =C3=A0 15:21, Sage Weil &lt;<a =
href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" class=3D"">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; a =
=C3=A9crit :</div><br class=3D"Apple-interchange-newline"><div =
class=3D""><div class=3D"">On Tue, 7 Jun 2016, M Ranga Swami Reddy =
wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">OK, =
understood...<br class=3D"">To fix the nearfull warn, I am reducing the =
weight of a specific OSD,<br class=3D"">which filled &gt;85%..<br =
class=3D"">Is this work-around advisable?<br class=3D""></blockquote><br =
class=3D"">Sure. &nbsp;This is what reweight-by-utilization does for =
you, but <br class=3D"">automatically.<br class=3D""><br =
class=3D"">sage<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">Thanks<br class=3D"">Swami<br class=3D""><br =
class=3D"">On Tue, Jun 7, 2016 at 6:37 PM, Sage Weil &lt;<a =
href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" class=3D"">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; =
wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">On Tue, 7 Jun =
2016, M Ranga Swami Reddy wrote:<br class=3D""><blockquote type=3D"cite" =
class=3D"">Hi Sage,<br class=3D""><blockquote type=3D"cite" =
class=3D"">Jewel and the latest hammer point release have an improved<br =
class=3D"">reweight-by-utilization (ceph osd =
test-reweight-by-utilization ... to dry<br class=3D"">run) to correct =
this.<br class=3D""></blockquote><br class=3D"">Thank you....But not =
planning to upgrade the cluster soon.<br class=3D"">So, in this case - =
are there any tunable options will help? like<br class=3D"">"crush =
tunable optimal" or so?<br class=3D"">OR any other configuration options =
change will help?<br class=3D""></blockquote><br class=3D"">Firefly also =
has reweight-by-utilization... it's just a bit less friendly<br =
class=3D"">than the newer versions. &nbsp;CRUSH tunables don't generally =
help here unless<br class=3D"">you have lots of OSDs that are =
down+out.<br class=3D""><br class=3D"">Note that firefly is no longer =
supported.<br class=3D""><br class=3D"">sage<br class=3D""><br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D""><br =
class=3D""><br class=3D"">Thanks<br class=3D"">Swami<br class=3D""><br =
class=3D""><br class=3D"">On Tue, Jun 7, 2016 at 6:00 PM, Sage Weil =
&lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" =
class=3D"">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D"">On Tue, 7 Jun 2016, M Ranga Swami Reddy =
wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">Hello,<br =
class=3D"">I have aorund 100 OSDs in my ceph cluster. In this a few OSDs =
filled<br class=3D"">with &gt;85% of data and few OSDs filled with =
~60%-70% of data.<br class=3D""><br class=3D"">Any reason why the =
unevenly OSDs filling happned? do I need to any<br class=3D"">tweaks on =
configuration to fix the above? Please advise.<br class=3D""><br =
class=3D"">PS: Ceph version is - 0.80.7<br class=3D""></blockquote><br =
class=3D"">Jewel and the latest hammer point release have an improved<br =
class=3D"">reweight-by-utilization (ceph osd =
test-reweight-by-utilization ... to dry<br class=3D"">run) to correct =
this.<br class=3D""><br class=3D"">sage<br class=3D""><br =
class=3D""></blockquote>--<br class=3D"">To unsubscribe from this list: =
send the line "unsubscribe ceph-devel" in<br class=3D"">the body of a =
message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
class=3D"">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br class=3D"">More majordomo =
info at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.html" =
class=3D"">http://vger.kernel.org/majordomo-info.html</a><br =
class=3D""><br class=3D""><br class=3D""></blockquote></blockquote><br =
class=3D""><br =
class=3D""></blockquote>_______________________________________________<br=
 class=3D"">ceph-users mailing list<br class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""></div></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_3ED17459-A8FA-488B-A0E2-B45D95902F9A--

--===============1161597136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1161597136==--
