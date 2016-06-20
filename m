From: Andrei Mikhailovsky <andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org>
Subject: Re: cluster down during backfilling,
 Jewel tunables and client IO optimisations
Date: Mon, 20 Jun 2016 21:16:59 +0100 (BST)
Message-ID: <1694046122.105664.1466453819626.JavaMail.zimbra@arhont.com>
References: <848514758.3747.1466265852627.JavaMail.zimbra@arhont.com>
	<31cbf96d-c79e-1e7d-19fd-df9e2d2a748f@ip-interactive.de>
	<1456968003.98467.1466423640703.JavaMail.zimbra@arhont.com>
	<nk92c8$knq$1@ger.gmane.org>
	<CAJ4mKGb28W-jPK7Z7wMzm7fC8Q5YPmqr+PeGS=Bz7jky4GfxuA@mail.gmail.com>
	<CAOnYue9FR5amxPkZ-5v6bntq9WN=YkDUGu0U4MSdj2k_eNiuWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1920754306=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAOnYue9FR5amxPkZ-5v6bntq9WN=YkDUGu0U4MSdj2k_eNiuWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Josef Johansson <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Swarbrick <daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1920754306==
Content-Type: multipart/alternative;
	boundary="----=_Part_105663_1390842661.1466453819624"

------=_Part_105663_1390842661.1466453819624
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Josef, 

are you saying that there is no ceph config option that can be used to provide IO to the vms while the ceph cluster is in heavy data move? I am really struggling to understand that this could be the case. I've read so much about ceph being the solution to the modern storage needs and that all of its components were designed to be redundant to provide an always on availability of the storage in case of upgrades and hardware failures. Has something been overlooked? 

Also, judging by a low number of people with similar issues I am thinking that there are a lot of ceph users which are still using non optimal profile, either because they don't want to risk the downtime or simply they don't know about the latest crush tunables. 

For any future updates, should I be scheduling a maintenance day or two and shutdown all vms prior to upgrading the cluster? It so seems like the backwards approach of the 90s and early 2000s ((( 

Cheers 

Andrei 

> From: "Josef Johansson" <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> To: "Gregory Farnum" <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Daniel Swarbrick"
> <daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
> Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel"
> <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Sent: Monday, 20 June, 2016 20:22:02
> Subject: Re: [ceph-users] cluster down during backfilling, Jewel tunables and
> client IO optimisations

> Hi,

> People ran into this when there were some changes in tunables that caused
> 70-100% movement, the solution was to find out what values that changed and
> increment them in the smallest steps possible.

> I've found that with major rearrangement in ceph the VMs does not neccesarily
> survive ( last time on a ssd cluster ), so linux and timeouts doesn't work well
> os my assumption. Which is true with any other storage backend out there ;)

> Regards,
> Josef
> On Mon, 20 Jun 2016, 19:51 Gregory Farnum, < gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org > wrote:

>> On Mon, Jun 20, 2016 at 8:33 AM, Daniel Swarbrick
>> < daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org > wrote:
>> > We have just updated our third cluster from Infernalis to Jewel, and are
>> > experiencing similar issues.

>> > We run a number of KVM virtual machines (qemu 2.5) with RBD images, and
>> > have seen a lot of D-state processes and even jbd/2 timeouts and kernel
>> > stack traces inside the guests. At first I thought the VMs were being
>> > starved of IO, but this is still happening after throttling back the
>> > recovery with:

>> > osd_max_backfills = 1
>> > osd_recovery_max_active = 1
>> > osd_recovery_op_priority = 1

>> > After upgrading the cluster to Jewel, I changed our crushmap to use the
>> > newer straw2 algorithm, which resulted in a little data movment, but no
>> > problems at that stage.

>> > Once the cluster had settled down again, I set tunables to optimal
>> > (hammer profile -> jewel profile), which has triggered between 50% and
>> > 70% misplaced PGs on our clusters. This is when the trouble started each
>> > time, and when we had cascading failures of VMs.

>> > However, after performing hard shutdowns on the VMs and restarting them,
>> > they seemed to be OK.

>> > At this stage, I have a strong suspicion that it is the introduction of
>> > "require_feature_tunables5 = 1" in the tunables. This seems to require
>> > all RADOS connections to be re-established.

>> Do you have any evidence of that besides the one restart?

>> I guess it's possible that we aren't kicking requests if the crush map
>> but not the rest of the osdmap changes, but I'd be surprised.
>> -Greg



>> > On 20/06/16 13:54, Andrei Mikhailovsky wrote:
>> >> Hi Oliver,

>>>> I am also seeing this as a strange behavriour indeed! I was going through the
>>>> logs and I was not able to find any errors or issues. There was also no
>> >> slow/blocked requests that I could see during the recovery process.

>>>> Does anyone has an idea what could be the issue here? I don't want to shut down
>> >> all vms every time there is a new release with updated tunable values.


>> >> Andrei



>> >> ----- Original Message -----
>> >>> From: "Oliver Dzombic" < info-cbyvsTkHNGAhzyAFmVfXCbNAH6kLmebB@public.gmane.org >
>> >>> To: "andrei" < andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org >, "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
>> >>> Sent: Sunday, 19 June, 2016 10:14:35
>>>>> Subject: Re: [ceph-users] cluster down during backfilling, Jewel tunables and
>> >>> client IO optimisations

>> >>> Hi,

>> >>> so far the key values for that are:

>> >>> osd_client_op_priority = 63 ( anyway default, but i set it to remember it )
>> >>> osd_recovery_op_priority = 1


>> >>> In addition i set:

>> >>> osd_max_backfills = 1
>> >>> osd_recovery_max_active = 1



>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

------=_Part_105663_1390842661.1466453819624
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi Josef,<br></div><div><br data-mce-bogus=
=3D"1"></div><div>are you saying that there is no ceph config option that c=
an be used to provide IO to the vms while the ceph cluster is in heavy data=
 move? I am really struggling to understand that this could be the case. I'=
ve read so much about ceph being the solution to the modern storage needs a=
nd that all of its components were designed to be redundant to provide an a=
lways on availability of the storage in case of upgrades and hardware failu=
res. Has something been overlooked?<br></div><div><br data-mce-bogus=3D"1">=
</div><div>Also, judging by a low number of people with similar issues I am=
 thinking that there are a lot of ceph users which are still using non opti=
mal profile, either because they don't want to risk the downtime or simply =
they don't know about the latest crush tunables.</div><div><br data-mce-bog=
us=3D"1"></div><div>For any future updates, should I be scheduling a mainte=
nance day or two and shutdown all vms prior to upgrading the cluster? It so=
 seems like the backwards approach of the 90s and early 2000s (((<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><div>Cheers<br data-mce-bogus=3D"1"></div><div><br data-m=
ce-bogus=3D"1"></div><div>Andrei<br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><div><br></div><hr id=3D"zwchr" data-marker=3D"__DI=
VIDER__"><div data-marker=3D"__HEADERS__"><blockquote style=3D"border-left:=
2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt;"><b>From: </b>"Josef Johansson" &lt;josef86@gmail.=
com&gt;<br><b>To: </b>"Gregory Farnum" &lt;gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;, "Daniel =
Swarbrick" &lt;daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org&gt;<br><b>Cc: </b>"ceph-us=
ers" &lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;, "ceph-devel" &lt;ceph-devel-fy+rA21nqHI@public.gmane.org=
rnel.org&gt;<br><b>Sent: </b>Monday, 20 June, 2016 20:22:02<br><b>Subject: =
</b>Re: [ceph-users] cluster down during backfilling, Jewel tunables and cl=
ient IO optimisations<br></blockquote></div><div data-marker=3D"__QUOTED_TE=
XT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><p dir=3D"=
ltr">Hi,</p>
<p dir=3D"ltr">People ran into this when there were some changes in tunable=
s that caused 70-100% movement, the solution was to find out what values th=
at changed and increment them in the smallest steps possible.</p>
<p dir=3D"ltr">I've found that with major rearrangement in ceph the VMs doe=
s not neccesarily survive ( last time on a ssd cluster ), so linux and time=
outs doesn't work well os my assumption. Which is true with any other stora=
ge backend out there ;)</p>
<p dir=3D"ltr">Regards,<br>
Josef</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, 20 Jun 2016, 19:51 =
Gregory Farnum, &lt;<a href=3D"mailto:gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank"=
>gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Mon, Jun 20, 2016 at 8:33 AM, Daniel Swarbrick<br>
&lt;<a href=3D"mailto:daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org" target=3D"_blank">=
daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org</a>&gt; wrote:<br>
&gt; We have just updated our third cluster from Infernalis to Jewel, and a=
re<br>
&gt; experiencing similar issues.<br>
&gt;<br>
&gt; We run a number of KVM virtual machines (qemu 2.5) with RBD images, an=
d<br>
&gt; have seen a lot of D-state processes and even jbd/2 timeouts and kerne=
l<br>
&gt; stack traces inside the guests. At first I thought the VMs were being<=
br>
&gt; starved of IO, but this is still happening after throttling back the<b=
r>
&gt; recovery with:<br>
&gt;<br>
&gt; osd_max_backfills =3D 1<br>
&gt; osd_recovery_max_active =3D 1<br>
&gt; osd_recovery_op_priority =3D 1<br>
&gt;<br>
&gt; After upgrading the cluster to Jewel, I changed our crushmap to use th=
e<br>
&gt; newer straw2 algorithm, which resulted in a little data movment, but n=
o<br>
&gt; problems at that stage.<br>
&gt;<br>
&gt; Once the cluster had settled down again, I set tunables to optimal<br>
&gt; (hammer profile -&gt; jewel profile), which has triggered between 50% =
and<br>
&gt; 70% misplaced PGs on our clusters. This is when the trouble started ea=
ch<br>
&gt; time, and when we had cascading failures of VMs.<br>
&gt;<br>
&gt; However, after performing hard shutdowns on the VMs and restarting the=
m,<br>
&gt; they seemed to be OK.<br>
&gt;<br>
&gt; At this stage, I have a strong suspicion that it is the introduction o=
f<br>
&gt; "require_feature_tunables5 =3D 1" in the tunables. This seems to requi=
re<br>
&gt; all RADOS connections to be re-established.<br>
<br>
Do you have any evidence of that besides the one restart?<br>
<br>
I guess it's possible that we aren't kicking requests if the crush map<br>
but not the rest of the osdmap changes, but I'd be surprised.<br>
-Greg<br>
<br>
&gt;<br>
&gt;<br>
&gt; On 20/06/16 13:54, Andrei Mikhailovsky wrote:<br>
&gt;&gt; Hi Oliver,<br>
&gt;&gt;<br>
&gt;&gt; I am also seeing this as a strange behavriour indeed! I was going =
through the logs and I was not able to find any errors or issues. There was=
 also no slow/blocked requests that I could see during the recovery process=
.<br>
&gt;&gt;<br>
&gt;&gt; Does anyone has an idea what could be the issue here? I don't want=
 to shut down all vms every time there is a new release with updated tunabl=
e values.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Andrei<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ----- Original Message -----<br>
&gt;&gt;&gt; From: "Oliver Dzombic" &lt;<a href=3D"mailto:info@ip-interacti=
ve.de" target=3D"_blank">info-cbyvsTkHNGAhzyAFmVfXCbNAH6kLmebB@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; To: "andrei" &lt;<a href=3D"mailto:andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org" target=
=3D"_blank">andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org</a>&gt;, "ceph-users" &lt;<a href=3D"mailto:c=
eph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&g=
t;<br>
&gt;&gt;&gt; Sent: Sunday, 19 June, 2016 10:14:35<br>
&gt;&gt;&gt; Subject: Re: [ceph-users] cluster down during backfilling, Jew=
el tunables and client IO optimisations<br>
&gt;&gt;<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; so far the key values for that are:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; osd_client_op_priority =3D 63 ( anyway default, but i set it t=
o remember it )<br>
&gt;&gt;&gt; osd_recovery_op_priority =3D 1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; In addition i set:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; osd_max_backfills =3D 1<br>
&gt;&gt;&gt; osd_recovery_max_active =3D 1<br>
&gt;&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>
<br>_______________________________________________<br>ceph-users mailing l=
ist<br>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>http://lists.ceph.com/listinfo.cgi/ceph=
-users-ceph.com<br></blockquote></div></div></body></html>
------=_Part_105663_1390842661.1466453819624--

--===============1920754306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1920754306==--
