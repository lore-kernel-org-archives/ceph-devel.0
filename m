From: Ben Hines <bhines-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RGW lifecycle not expiring objects
Date: Mon, 5 Jun 2017 11:07:08 -0700
Message-ID: <CABGPr5nEvjG2AjSskT_RZd271ck5Z4Ow790azVP-JLGvDXWMsg@mail.gmail.com>
References: <CABGPr5nfykSv=ib6N_jMOarOF=O1XaPLxCXY6nNYR81wa62TBQ@mail.gmail.com>
	<CABGPr5=5y3NBJ_jGB1w=2=DeHU1GF4f7Ji+kTAJ_4f+O37hTFg@mail.gmail.com>
	<e19ebc5a-c8c1-eefb-acec-65fbc0284101@umn.edu>
	<trinity-9ef02e67-6909-42f8-ab06-a750a2bfab3c-1496441134227@3capp-gmx-bs48>
	<CADRKj5ShtTBA=_3e89jC-t31sArHZ=9Wfc5cA5VRHKFfd+gz0A@mail.gmail.com>
	<trinity-b11b03b1-bc6b-466e-ba26-77e1154d575f-1496604855693@3capp-gmx-bs77>
	<trinity-76fa44cc-8cd5-41f0-90e9-4a6d2e603ae6-1496617549501@3capp-gmx-bs31>
	<trinity-9ac6e555-43be-4a82-b5b5-e120d3af1e8b-1496617969363@3capp-gmx-bs31>
	<trinity-fe7badd9-ecbc-4d65-8fa0-231496938a25-1496618162797@3capp-gmx-bs31>
	<3c3ff290-8032-1e03-dd82-eefd2ac01d34@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1389657897=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <3c3ff290-8032-1e03-dd82-eefd2ac01d34-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Daniel Gryniewicz <dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1389657897==
Content-Type: multipart/alternative; boundary="f403045f557842a65905513a60df"

--f403045f557842a65905513a60df
Content-Type: text/plain; charset="UTF-8"

FWIW lifecycle is working for us. I did have to research to find the
appropriate lc config file settings, the documentation for which is found
in a git pull request (waiting for another release?) rather than on the
Ceph docs site. https://github.com/ceph/ceph/pull/13990


Try these:
debug rgw = 20
rgw lifecycle work time = 00:01-23:59


and see if you have lifecycles listed when you run:


radosgw-admin lc list


2017-06-05 10:58:00.473957 7f3429f77c80  0 System already converted
[
    {
        "bucket": ":bentest:default.653959.6",
        "status": "COMPLETE"
    },
    {
        "bucket": ":<redacted>:default.24713983.1",
        "status": "PROCESSING"
    },
    {
        "bucket": ":<redacted>:default.24713983.2",
        "status": "PROCESSING"
    },

....


At 10 loglevel, the lifecycle processor logs 'DELETED' each time it deletes
something: https://github.com/ceph/ceph/blob/master/src/rgw/rgw_lc.cc#L388

 grep --text DELETED client.<hostname>.log | wc -l
121853


-Ben

On Mon, Jun 5, 2017 at 6:16 AM, Daniel Gryniewicz <dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Kraken has lifecycle, Jewel does not.
>
> Daniel
>
>
> On 06/04/2017 07:16 PM, ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org wrote:
>
>>
>> grrr... sorry && and again as text :|
>>
>>
>> Gesendet: Montag, 05. Juni 2017 um 01:12 Uhr
>> Von: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
>> An: "Yehuda Sadeh-Weinraub" <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>,
>> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Betreff: Re: [ceph-users] RGW lifecycle not expiring objects
>>
>>
>>
>> Hi (again) Yehuda.
>>
>> Looping in ceph-devel...
>>
>> Could it be that lifecycle is still not implemented neither in Jewel nor
>> in Kraken, even if release notes and other places say so?
>>
>> https://www.spinics.net/lists/ceph-devel/msg34492.html
>> https://github.com/ceph/ceph-ci/commit/7d48f62f5c86913d8f00b
>> 44d46a04a52d338907c
>> https://github.com/ceph/ceph-ci/commit/9162bd29594d34429a095
>> 62ed60a32a0703940ea
>>
>> Thanks & regards
>>  Anton
>>
>>
>> Gesendet: Sonntag, 04. Juni 2017 um 21:34 Uhr
>> Von: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
>> An: "Yehuda Sadeh-Weinraub" <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>> Betreff: Re: [ceph-users] RGW lifecycle not expiring objects
>> Hi Yahuda.
>>
>> Well, here we go: http://tracker.ceph.com/issues
>> /20177[http://tracker.ceph.com/issues/20177]
>>
>> As it's my first one, hope it's ok as it is...
>>
>> Thanks & regards
>> Anton
>>
>>
>> Gesendet: Samstag, 03. Juni 2017 um 00:14 Uhr
>> Von: "Yehuda Sadeh-Weinraub" <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> An: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
>> Cc: "Graham Allan" <gta-OJFnDUYgAso@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>> Betreff: Re: [ceph-users] RGW lifecycle not expiring objects
>> Have you opened a ceph tracker issue, so that we don't lose track of
>> the problem?
>>
>> Thanks,
>> Yehuda
>>
>> On Fri, Jun 2, 2017 at 3:05 PM, <ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org> wrote:
>>
>>> Hi Graham.
>>>
>>> We are on Kraken and have the same problem with "lifecycle". Various
>>> (other) tools like s3cmd or CyberDuck do show the applied "expiration"
>>> settings, but objects seem never to be purged.
>>>
>>> If you should have new findings, hints,... PLEASE share/let me know.
>>>
>>> Thanks a lot!
>>> Anton
>>>
>>>
>>> Gesendet: Freitag, 19. Mai 2017 um 22:44 Uhr
>>> Von: "Graham Allan" <gta-OJFnDUYgAso@public.gmane.org>
>>> An: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> Betreff: [ceph-users] RGW lifecycle not expiring objects
>>> I've been having a hard time getting the s3 object lifecycle to do
>>> anything here. I was able to set a lifecycle on a test bucket. As others
>>> also seem to have found, I do get an EACCES error on setting the
>>> lifecycle, but it does however get stored:
>>>
>>> % aws --endpoint-url https://xxx.xxx.xxx.xxx[https://xxx.xxx.xxx.xxx][
>>>> https://xxx.xxx.xxx.xxx[https://xxx.xxx.xxx.xxx]] s3api
>>>> get-bucket-lifecycle-configuration --bucket=testgta
>>>> {
>>>> "Rules": [
>>>> {
>>>> "Status": "Enabled",
>>>> "Prefix": "",
>>>> "Expiration": {
>>>> "Days": 3
>>>> },
>>>> "ID": "test"
>>>> }
>>>> ]
>>>> }
>>>>
>>>
>>> but many days later I have yet to see any object actually get expired.
>>> There are some hints in the rgw log that the expiry thread does run
>>> periodically:
>>>
>>> 2017-05-19 03:49:03.281347 7f74f1134700 2 RGWDataChangesLog::ChangesRenewThread:
>>>> start
>>>> 2017-05-19 03:49:16.356022 7f74ef931700 2 object expiration: start
>>>> 2017-05-19 03:49:16.356036 7f74ef931700 20 proceeding shard =
>>>> obj_delete_at_hint.0000000000
>>>> 2017-05-19 03:49:16.359785 7f74ef931700 20 proceeding shard =
>>>> obj_delete_at_hint.0000000001
>>>> 2017-05-19 03:49:16.364667 7f74ef931700 20 proceeding shard =
>>>> obj_delete_at_hint.0000000002
>>>> 2017-05-19 03:49:16.369636 7f74ef931700 20 proceeding shard =
>>>> obj_delete_at_hint.0000000003
>>>>
>>> ...
>>>
>>>> 2017-05-19 03:49:16.803270 7f74ef931700 20 proceeding shard =
>>>> obj_delete_at_hint.0000000126
>>>> 2017-05-19 03:49:16.806423 7f74ef931700 2 object expiration: stop
>>>>
>>>
>>> "radosgw-admin lc process" gives me no output unless I enable debug,
>>> then:
>>>
>>> ]# radosgw-admin lc process
>>>> 2017-05-19 15:28:46.383049 7fedb9ffb700 2 RGWDataChangesLog::ChangesRenewThread:
>>>> start
>>>> 2017-05-19 15:28:46.421806 7feddc240c80 10 Cannot find current period
>>>> zone using local zone
>>>> 2017-05-19 15:28:46.453431 7feddc240c80 2 all 8 watchers are set,
>>>> enabling cache
>>>> 2017-05-19 15:28:46.614991 7feddc240c80 2 removed watcher, disabling
>>>> cache
>>>>
>>>
>>> "radosgw-admin lc list" seems to return "empty" output:
>>>
>>> # radosgw-admin lc list
>>>> []
>>>>
>>>
>>> Is there anything obvious that I might be missing?
>>>
>>> Graham
>>> --
>>> Graham Allan
>>> Minnesota Supercomputing Institute - gta-OJFnDUYgAso@public.gmane.org
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http:
>>> //lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]]]
>>>
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http:
>>> //lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]]
>>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http:
>> //lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://
>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://
>> lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]
>>
>>  _______________________________________________ ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org http://lists.ceph.com/listinfo
>> .cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/
>> ceph-users-ceph.com]
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--f403045f557842a65905513a60df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FWIW lifecycle is working for us. I did have to research t=
o find the appropriate lc config file settings, the documentation for which=
 is found in a git pull request (waiting for another release?) rather than =
on the Ceph docs site.=C2=A0<a href=3D"https://github.com/ceph/ceph/pull/13=
990">https://github.com/ceph/ceph/pull/13990</a><div><br></div><div><br><di=
v>Try these:</div><div><div>debug rgw =3D 20</div><div>rgw lifecycle work t=
ime =3D 00:01-23:59</div><div><br></div><div><br></div><div>and see if you =
have lifecycles listed when you run:</div><div><br></div><div><br></div><di=
v><div>radosgw-admin lc list</div><div><br></div><div><br></div><div>2017-0=
6-05 10:58:00.473957 7f3429f77c80 =C2=A00 System already converted</div><di=
v>[</div><div>=C2=A0 =C2=A0 {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;b=
ucket&quot;: &quot;:bentest:default.653959.6&quot;,</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;status&quot;: &quot;COMPLETE&quot;</div><div>=C2=A0 =
=C2=A0 },</div><div>=C2=A0 =C2=A0 {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;bucket&quot;: &quot;:&lt;redacted&gt;:default.24713983.1&quot;,</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: &quot;PROCESSING&quot;<=
/div><div>=C2=A0 =C2=A0 },</div><div>=C2=A0 =C2=A0 {</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bucket&quot;: &quot;:&lt;redacted&gt;:default.24713=
983.2&quot;,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: &quo=
t;PROCESSING&quot;</div><div>=C2=A0 =C2=A0 },</div></div><div><br></div><di=
v>....</div><div><br></div><div><br></div><div>At 10 loglevel, the lifecycl=
e processor logs &#39;DELETED&#39; each time it deletes something:=C2=A0<a =
href=3D"https://github.com/ceph/ceph/blob/master/src/rgw/rgw_lc.cc#L388">ht=
tps://github.com/ceph/ceph/blob/master/src/rgw/rgw_lc.cc#L388</a></div><div=
><br></div><div><div>=C2=A0grep --text DELETED client.&lt;hostname&gt;.log =
| wc -l</div><div>121853</div></div><div><br></div><div><br></div><div>-Ben=
</div></div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Mon, Jun 5, 2017 at 6:16 AM, Daniel Gryniewicz <span dir=3D"ltr">=
&lt;<a href=3D"mailto:dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Kraken has lifecycle,=
 Jewel does not.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Daniel</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On 06/04/2017 07:16 PM, <a href=3D"mailto:ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org" tar=
get=3D"_blank">ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org</a> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
grrr... sorry &amp;&amp; and again as text :|<br>
<br>
<br>
Gesendet: Montag, 05. Juni 2017 um 01:12 Uhr<br>
Von: <a href=3D"mailto:ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org" target=3D"_blank">ceph=
.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org</a><br>
An: &quot;Yehuda Sadeh-Weinraub&quot; &lt;<a href=3D"mailto:yehuda@redhat.c=
om" target=3D"_blank">yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ce=
ph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&quot; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFI@public.gmane.org=
ph.com" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;, <a href=3D"mai=
lto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" target=3D"_blank">ceph-devel-u79uwXL29TaqPxH82wqD4g@public.gmane.org=
g</a><br>
Betreff: Re: [ceph-users] RGW lifecycle not expiring objects<br>
<br>
<br>
<br>
Hi (again) Yehuda.<br>
<br>
Looping in ceph-devel...<br>
<br>
Could it be that lifecycle is still not implemented neither in Jewel nor in=
 Kraken, even if release notes and other places say so?<br>
<br>
<a href=3D"https://www.spinics.net/lists/ceph-devel/msg34492.html" rel=3D"n=
oreferrer" target=3D"_blank">https://www.spinics.net/lists/<wbr>ceph-devel/=
msg34492.html</a><br>
<a href=3D"https://github.com/ceph/ceph-ci/commit/7d48f62f5c86913d8f00b44d4=
6a04a52d338907c" rel=3D"noreferrer" target=3D"_blank">https://github.com/ce=
ph/ceph-c<wbr>i/commit/7d48f62f5c86913d8f00b<wbr>44d46a04a52d338907c</a><br=
>
<a href=3D"https://github.com/ceph/ceph-ci/commit/9162bd29594d34429a09562ed=
60a32a0703940ea" rel=3D"noreferrer" target=3D"_blank">https://github.com/ce=
ph/ceph-c<wbr>i/commit/9162bd29594d34429a095<wbr>62ed60a32a0703940ea</a><br=
>
<br>
Thanks &amp; regards<br>
=C2=A0Anton<br>
<br>
<br>
Gesendet: Sonntag, 04. Juni 2017 um 21:34 Uhr<br>
Von: <a href=3D"mailto:ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org" target=3D"_blank">ceph=
.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org</a><br>
An: &quot;Yehuda Sadeh-Weinraub&quot; &lt;<a href=3D"mailto:yehuda@redhat.c=
om" target=3D"_blank">yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ce=
ph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&quot; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFI@public.gmane.org=
ph.com" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<br>
Betreff: Re: [ceph-users] RGW lifecycle not expiring objects<br>
Hi Yahuda.<br>
<br>
Well, here we go: <a href=3D"http://tracker.ceph.com/issues/20177%5Bhttp://=
tracker.ceph.com/issues/20177%5D" rel=3D"noreferrer" target=3D"_blank">http=
://tracker.ceph.com/issues<wbr>/20177[http://tracker.ceph.<wbr>com/issues/2=
0177]</a><br>
<br>
As it&#39;s my first one, hope it&#39;s ok as it is...<br>
<br>
Thanks &amp; regards<br>
Anton<br>
<br>
<br>
Gesendet: Samstag, 03. Juni 2017 um 00:14 Uhr<br>
Von: &quot;Yehuda Sadeh-Weinraub&quot; &lt;<a href=3D"mailto:yehuda@redhat.=
com" target=3D"_blank">yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
An: <a href=3D"mailto:ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org" target=3D"_blank">ceph.=
novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org</a><br>
Cc: &quot;Graham Allan&quot; &lt;<a href=3D"mailto:gta-OJFnDUYgAso@public.gmane.org" target=3D"_=
blank">gta-OJFnDUYgAso@public.gmane.org</a>&gt;, &quot;<a href=3D"mailto:ceph-users-idqoXFIVOFKIjjVqG0RrOw@public.gmane.org=
om" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&quot; &lt;<a href=3D"ma=
ilto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a>&gt;<br>
Betreff: Re: [ceph-users] RGW lifecycle not expiring objects<br>
Have you opened a ceph tracker issue, so that we don&#39;t lose track of<br=
>
the problem?<br>
<br>
Thanks,<br>
Yehuda<br>
<br>
On Fri, Jun 2, 2017 at 3:05 PM, &lt;<a href=3D"mailto:ceph.novice@habmalnef=
rage.de" target=3D"_blank">ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Graham.<br>
<br>
We are on Kraken and have the same problem with &quot;lifecycle&quot;. Vari=
ous (other) tools like s3cmd or CyberDuck do show the applied &quot;expirat=
ion&quot; settings, but objects seem never to be purged.<br>
<br>
If you should have new findings, hints,... PLEASE share/let me know.<br>
<br>
Thanks a lot!<br>
Anton<br>
<br>
<br>
Gesendet: Freitag, 19. Mai 2017 um 22:44 Uhr<br>
Von: &quot;Graham Allan&quot; &lt;<a href=3D"mailto:gta-OJFnDUYgAso@public.gmane.org" target=3D"=
_blank">gta-OJFnDUYgAso@public.gmane.org</a>&gt;<br>
An: <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-use=
rs-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
Betreff: [ceph-users] RGW lifecycle not expiring objects<br>
I&#39;ve been having a hard time getting the s3 object lifecycle to do<br>
anything here. I was able to set a lifecycle on a test bucket. As others<br=
>
also seem to have found, I do get an EACCES error on setting the<br>
lifecycle, but it does however get stored:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
% aws --endpoint-url <a href=3D"https://xxx.xxx.xxx.xxx" rel=3D"noreferrer"=
 target=3D"_blank">https://xxx.xxx.xxx.xxx</a>[<a href=3D"https://xxx.xxx.x=
xx.xxx" rel=3D"noreferrer" target=3D"_blank">https:<wbr>//xxx.xxx.xxx.xxx</=
a>][<a href=3D"https://xxx.xxx.xxx.xxx" rel=3D"noreferrer" target=3D"_blank=
">https://xxx<wbr>.xxx.xxx.xxx</a>[<a href=3D"https://xxx.xxx.xxx.xxx" rel=
=3D"noreferrer" target=3D"_blank">https://xxx.xxx.<wbr>xxx.xxx</a>]] s3api =
get-bucket-lifecycle-configura<wbr>tion --bucket=3Dtestgta<br>
{<br>
&quot;Rules&quot;: [<br>
{<br>
&quot;Status&quot;: &quot;Enabled&quot;,<br>
&quot;Prefix&quot;: &quot;&quot;,<br>
&quot;Expiration&quot;: {<br>
&quot;Days&quot;: 3<br>
},<br>
&quot;ID&quot;: &quot;test&quot;<br>
}<br>
]<br>
}<br>
</blockquote>
<br>
but many days later I have yet to see any object actually get expired.<br>
There are some hints in the rgw log that the expiry thread does run<br>
periodically:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
2017-05-19 03:49:03.281347 7f74f1134700 2 RGWDataChangesLog::ChangesRene<wb=
r>wThread: start<br>
2017-05-19 03:49:16.356022 7f74ef931700 2 object expiration: start<br>
2017-05-19 03:49:16.356036 7f74ef931700 20 proceeding shard =3D obj_delete_=
at_hint.0000000000<br>
2017-05-19 03:49:16.359785 7f74ef931700 20 proceeding shard =3D obj_delete_=
at_hint.0000000001<br>
2017-05-19 03:49:16.364667 7f74ef931700 20 proceeding shard =3D obj_delete_=
at_hint.0000000002<br>
2017-05-19 03:49:16.369636 7f74ef931700 20 proceeding shard =3D obj_delete_=
at_hint.0000000003<br>
</blockquote>
...<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
2017-05-19 03:49:16.803270 7f74ef931700 20 proceeding shard =3D obj_delete_=
at_hint.0000000126<br>
2017-05-19 03:49:16.806423 7f74ef931700 2 object expiration: stop<br>
</blockquote>
<br>
&quot;radosgw-admin lc process&quot; gives me no output unless I enable deb=
ug, then:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
]# radosgw-admin lc process<br>
2017-05-19 15:28:46.383049 7fedb9ffb700 2 RGWDataChangesLog::ChangesRene<wb=
r>wThread: start<br>
2017-05-19 15:28:46.421806 7feddc240c80 10 Cannot find current period zone =
using local zone<br>
2017-05-19 15:28:46.453431 7feddc240c80 2 all 8 watchers are set, enabling =
cache<br>
2017-05-19 15:28:46.614991 7feddc240c80 2 removed watcher, disabling cache<=
br>
</blockquote>
<br>
&quot;radosgw-admin lc list&quot; seems to return &quot;empty&quot; output:=
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
# radosgw-admin lc list<br>
[]<br>
</blockquote>
<br>
Is there anything obvious that I might be missing?<br>
<br>
Graham<br>
--<br>
Graham Allan<br>
Minnesota Supercomputing Institute - <a href=3D"mailto:gta-OJFnDUYgAso@public.gmane.org" target=
=3D"_blank">gta-OJFnDUYgAso@public.gmane.org</a><br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5Bhttp://=
lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5D%5Bhttp://lists.ceph.com/=
listinfo.cgi/ceph-users-ceph.com%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-=
users-ceph.com%5D%5D%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.c=
om%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5D%5Bhttp://lis=
ts.ceph.com/listinfo.cgi/ceph-users-ceph.com%5Bhttp://lists.ceph.com/listin=
fo.cgi/ceph-users-ceph.com%5D%5D%5D%5Bhttp://lists.ceph.com/listinfo.cgi/ce=
ph-users-ceph.com%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%=
5D%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5Bhttp://lists.=
ceph.com/listinfo.cgi/ceph-users-ceph.com%5D%5D%5Bhttp://lists.ceph.com/lis=
tinfo.cgi/ceph-users-ceph.com%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-use=
rs-ceph.com%5D%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5Bh=
ttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5D%5D%5D%5D" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com[http:<wbr>//lists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.=
com][http://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.com[http:=
//<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.com]][http://<wbr>l=
ists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.com[http://<wbr>lists.ceph.=
com/listinfo.cgi/<wbr>ceph-users-ceph.com][http://<wbr>lists.ceph.com/listi=
nfo.cgi/<wbr>ceph-users-ceph.com[http://<wbr>lists.ceph.com/listinfo.cgi/<w=
br>ceph-users-ceph.com]]][http://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph=
-users-ceph.com[http://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-users-cep=
h.com][http://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.com[htt=
p://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.com]][http://<wbr=
>lists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.com[http://<wbr>lists.cep=
h.com/listinfo.cgi/<wbr>ceph-users-ceph.com][http://<wbr>lists.ceph.com/lis=
tinfo.cgi/<wbr>ceph-users-ceph.com[http://<wbr>lists.ceph.com/listinfo.cgi/=
<wbr>ceph-users-ceph.com]]]]</a><br>
<br>
<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5Bhttp://=
lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5D%5Bhttp://lists.ceph.com/=
listinfo.cgi/ceph-users-ceph.com%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-=
users-ceph.com%5D%5D%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.c=
om%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5D%5Bhttp://lis=
ts.ceph.com/listinfo.cgi/ceph-users-ceph.com%5Bhttp://lists.ceph.com/listin=
fo.cgi/ceph-users-ceph.com%5D%5D%5D" rel=3D"noreferrer" target=3D"_blank">h=
ttp://lists.ceph.com/listinfo<wbr>.cgi/ceph-users-ceph.com[http:<wbr>//list=
s.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.com][http://<wbr>lists.ceph.co=
m/listinfo.cgi/<wbr>ceph-users-ceph.com[http://<wbr>lists.ceph.com/listinfo=
.cgi/<wbr>ceph-users-ceph.com]][http://<wbr>lists.ceph.com/listinfo.cgi/<wb=
r>ceph-users-ceph.com[http://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-use=
rs-ceph.com][http://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.c=
om[http://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-users-ceph.com]]]</a><=
br>
</blockquote>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5Bhttp://=
lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5D%5Bhttp://lists.ceph.com/=
listinfo.cgi/ceph-users-ceph.com%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-=
users-ceph.com%5D%5D" rel=3D"noreferrer" target=3D"_blank">http://lists.cep=
h.com/listinfo<wbr>.cgi/ceph-users-ceph.com[http:<wbr>//lists.ceph.com/list=
info.cgi/<wbr>ceph-users-ceph.com][http://<wbr>lists.ceph.com/listinfo.cgi/=
<wbr>ceph-users-ceph.com[http://<wbr>lists.ceph.com/listinfo.cgi/<wbr>ceph-=
users-ceph.com]]</a><br>
<br>
=C2=A0_____________________________<wbr>__________________ ceph-users maili=
ng list <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph=
-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> <a href=3D"http://lists.ceph.com/listinfo.cgi/cep=
h-users-ceph.com%5Bhttp://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com%5=
D" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>=
.cgi/ceph-users-ceph.com[http:<wbr>//lists.ceph.com/listinfo.cgi/<wbr>ceph-=
users-ceph.com]</a><br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
<br>
</blockquote>
<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
</div></div></blockquote></div><br></div>

--f403045f557842a65905513a60df--

--===============1389657897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1389657897==--
