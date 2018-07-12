From: Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org>
Subject: Re: KPIs for Ceph/OSD client latency / deepscrub
 latency overhead
Date: Thu, 12 Jul 2018 14:51:27 +0200
Message-ID: <CAD9yTbFL_0N+CK+8_WzPMEVCVesH3tpMRR1HCtuCOpBkJx1Yaw@mail.gmail.com>
References: <5b5dcca8-9f82-e785-885a-20d74c6a81a7@256bit.org>
 <CAD9yTbGZyqEYJTWgWTQ2SbDc6pfvRqv=eGRKw_ebNVbE4xMWxQ@mail.gmail.com>
 <d0a8d024-3d62-f3c0-31e1-046747d0d9f6@256bit.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1730858846808448779=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <d0a8d024-3d62-f3c0-31e1-046747d0d9f6-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?Q?Marc_Sch=C3=B6chlin?= <ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1730858846808448779==
Content-Type: multipart/alternative; boundary="00000000000052ff6d0570ccd214"

--00000000000052ff6d0570ccd214
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-07-12 8:37 GMT+02:00 Marc Sch=C3=B6chlin <ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org>:

>
> In a first step i just would like to have  two simple KPIs which describe
> a average/aggregated write/read latency of these statistics.
>
> Are there tools/other functionalities which provide this in a simple way?
>
It's one of the main KPI our management software collects and visualizes:
https://croit.io

IIRC some of the other stats collectors also already collect these metrics,
at least I recall using it with Telegraf/InfluxDB.
But it's also really easy to collect yourself (I've once written it in bash
for some weird collector for a client), the only
hurdle is that you need to calculate the derivate because it collects a
running average.
I've some slides from our training about these metrics:
https://static.croit.io/ceph-training-examples/ceph-training-example-admin-=
socket.pdf
(Not much in there, it's more of a hands-on lab)



Paul



> Regards
> Marc
>
> Am 11.07.2018 um 18:42 schrieb Paul Emmerich:
>
> Hi,
>
> from experience: commit/apply_latency are not good metrics, the only good
> thing about them is that they are really easy to track.
> But we have found them to be almost completely useless in the real world.
>
> We track the op_*_latency metrics from perf dump and found them to be ver=
y
> helpful, they are more annoying to track due to their
> format. The median OSD is a good indicator and so is the slowest OSD.
>
> Paul
>
> 2018-07-11 17:50 GMT+02:00 Marc Sch=C3=B6chlin <ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org>:
>
>> Hello ceph-users and ceph-devel list,
>>
>> we got in production with our new shiny luminous (12.2.5) cluster.
>> This cluster runs SSD and HDD based OSD pools.
>>
>> To ensure the service quality of the cluster and to have a baseline for
>> client latency optimization (i.e. in the area of deepscrub optimization)
>> we would like to have statistics about the client interaction latency of
>> our cluster.
>>
>> Which measures can be suitable to get such a "aggregated by
>> device_class" average latency KPI?
>> Also a percentile rank would be great (% amount of requests serviced by
>> < 5ms,  % amount of requests serviced by  < 20ms, % amount of requests
>> serviced by  < 50ms, ...)
>>
>> The following command provides a overview over the commit latency of the
>> osds but no average latency and no information about the device_class.
>>
>> ceph osd perf -f json-pretty
>>
>> {
>>     "osd_perf_infos": [
>>         {
>>             "id": 71,
>>             "perf_stats": {
>>                 "commit_latency_ms": 2,
>>                 "apply_latency_ms": 0
>>             }
>>         },
>>         {
>>             "id": 70,
>>             "perf_stats": {
>>                 "commit_latency_ms": 3,
>>                 "apply_latency_ms": 0
>>             }
>>
>> Device class information can be extracted of "ceph df -f json-pretty".
>>
>> But building averages of averages not seems to be a good thing .... :-)
>>
>> It seems that i can get more detailed information using the "ceph daemon
>> osd.<nr> perf histogram dump" command.
>> This seems to deliver the percentile rank information in a good detail
>> level.
>> (http://docs.ceph.com/docs/luminous/dev/perf_histograms/)
>>
>> My questions:
>>
>> Are there tools to analyze and aggregate these measures for a group of
>> OSDs?
>>
>> Which measures should i use as a baseline for client latency optimizatio=
n?
>>
>> What is the time horizon of these measures?
>>
>> I sometimes see messages like this in my log.
>> This seems to be sourced in deep scrubbing. How can find the
>> source/solution of this problem?
>>
>> 2018-07-11 16:58:55.064497 mon.ceph-mon-s43 [INF] Cluster is now healthy
>> 2018-07-11 16:59:15.141214 mon.ceph-mon-s43 [WRN] Health check failed: 4
>> slow requests are blocked > 32 sec (REQUEST_SLOW)
>> 2018-07-11 16:59:25.037707 mon.ceph-mon-s43 [WRN] Health check update: 9
>> slow requests are blocked > 32 sec (REQUEST_SLOW)
>> 2018-07-11 16:59:30.038001 mon.ceph-mon-s43 [WRN] Health check update:
>> 23 slow requests are blocked > 32 sec (REQUEST_SLOW)
>> 2018-07-11 16:59:35.210900 mon.ceph-mon-s43 [WRN] Health check update:
>> 27 slow requests are blocked > 32 sec (REQUEST_SLOW)
>> 2018-07-11 16:59:45.038718 mon.ceph-mon-s43 [WRN] Health check update:
>> 29 slow requests are blocked > 32 sec (REQUEST_SLOW)
>> 2018-07-11 16:59:50.038955 mon.ceph-mon-s43 [WRN] Health check update:
>> 39 slow requests are blocked > 32 sec (REQUEST_SLOW)
>> 2018-07-11 16:59:55.281279 mon.ceph-mon-s43 [WRN] Health check update:
>> 44 slow requests are blocked > 32 sec (REQUEST_SLOW)
>> 2018-07-11 17:00:00.000121 mon.ceph-mon-s43 [WRN] overall HEALTH_WARN 12
>> slow requests are blocked > 32 sec
>> 2018-07-11 17:00:05.039677 mon.ceph-mon-s43 [WRN] Health check update:
>> 12 slow requests are blocked > 32 sec (REQUEST_SLOW)
>> 2018-07-11 17:00:09.329897 mon.ceph-mon-s43 [INF] Health check cleared:
>> REQUEST_SLOW (was: 12 slow requests are blocked > 32 sec)
>> 2018-07-11 17:00:09.329919 mon.ceph-mon-s43 [INF] Cluster is now healthy
>>
>> Regards
>> Marc
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
>
>
> --
> Paul Emmerich
>
> Looking for help with your Ceph cluster? Contact us at https://croit.io
>
> croit GmbH
> Freseniusstr. 31h
> <https://maps.google.com/?q=3DFreseniusstr.+31h+%0D%0A+++++++++++++++++++=
+81247+M%C3%BCnchen&entry=3Dgmail&source=3Dg>
> 81247 M=C3=BCnchen
> www.croit.io
> Tel: +49 89 1896585 90
>
>
>


--=20
Paul Emmerich

Looking for help with your Ceph cluster? Contact us at https://croit.io

croit GmbH
Freseniusstr. 31h
81247 M=C3=BCnchen
www.croit.io
Tel: +49 89 1896585 90

--00000000000052ff6d0570ccd214
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-07-12 8:37 GMT+02:00 Marc Sch=C3=B6chlin <span dir=3D"ltr">&lt;<a =
href=3D"mailto:ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org" target=3D"_blank">ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF"><br><p>
      In a first step i just would like to have=C2=A0 two simple KPIs which
      describe a average/aggregated write/read latency of these
      statistics.</p>
    <p>Are there tools/other functionalities which provide this in a
      simple way?<br></p></div></blockquote><div></div><div>It&#39;s one of=
 the main KPI our management software collects and visualizes: <a href=3D"h=
ttps://croit.io">https://croit.io</a><br></div><div><br>IIRC some of the ot=
her stats collectors also already collect these metrics, at least I recall =
using it with Telegraf/InfluxDB.<br></div><div>But it&#39;s also really eas=
y to collect yourself (I&#39;ve once written it in bash for some weird coll=
ector for a client), the only<br></div><div>hurdle is that you need to calc=
ulate the derivate because it collects a running average.<br></div><div>I&#=
39;ve some slides from our training about these metrics: <a href=3D"https:/=
/static.croit.io/ceph-training-examples/ceph-training-example-admin-socket.=
pdf">https://static.croit.io/ceph-training-examples/ceph-training-example-a=
dmin-socket.pdf</a><br></div><div>(Not much in there, it&#39;s more of a ha=
nds-on lab)<br></div><div><br><br><br></div><div>Paul<br></div><div><br>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"=
#FFFFFF"><p>
    </p>
    <p>Regards<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
      Marc<br>
    </font></span></p><div><div class=3D"gmail-h5">
    <br>
    <div class=3D"gmail-m_-7622038527760407528moz-cite-prefix">Am 11.07.201=
8 um 18:42 schrieb Paul
      Emmerich:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>Hi,</div>
        <div><br>
        </div>
        <div>from experience: commit/apply_latency are not good metrics,
          the only good thing about them is that they are really easy to
          track.</div>
        <div>But we have found them to be almost completely useless in
          the real world.<br>
        </div>
        <div><br>
        </div>
        <div>We track the op_*_latency metrics from perf dump and found
          them to be very helpful, they are more annoying to track due
          to their</div>
        <div>format. The median OSD is a good indicator and so is the
          slowest OSD.<br>
        </div>
        <div><br>
        </div>
        <div>Paul<br>
        </div>
      </div>
      <div class=3D"gmail_extra"><br>
        <div class=3D"gmail_quote">2018-07-11 17:50 GMT+02:00 Marc
          Sch=C3=B6chlin <span dir=3D"ltr">&lt;<a href=3D"mailto:ms@256bit.=
org" target=3D"_blank">ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org</a>&gt;</span>:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello
            ceph-users and ceph-devel list,<br>
            <br>
            we got in production with our new shiny luminous (12.2.5)
            cluster.<br>
            This cluster runs SSD and HDD based OSD pools.<br>
            <br>
            To ensure the service quality of the cluster and to have a
            baseline for<br>
            client latency optimization (i.e. in the area of deepscrub
            optimization)<br>
            we would like to have statistics about the client
            interaction latency of<br>
            our cluster.<br>
            <br>
            Which measures can be suitable to get such a &quot;aggregated b=
y<br>
            device_class&quot; average latency KPI?<br>
            Also a percentile rank would be great (% amount of requests
            serviced by=C2=A0<br>
            &lt; 5ms,=C2=A0 % amount of requests serviced by=C2=A0 &lt; 20m=
s, %
            amount of requests<br>
            serviced by=C2=A0 &lt; 50ms, ...)<br>
            <br>
            The following command provides a overview over the commit
            latency of the<br>
            osds but no average latency and no information about the
            device_class.<br>
            <br>
            ceph osd perf -f json-pretty<br>
            <br>
            {<br>
            =C2=A0=C2=A0=C2=A0 &quot;osd_perf_infos&quot;: [<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &quot;id&quot;: 71,<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &quot;perf_stats&quot;: {<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;commit_latency_ms&quot;: 2,<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;apply_latency_ms&quot;: 0<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &quot;id&quot;: 70,<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &quot;perf_stats&quot;: {<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;commit_latency_ms&quot;: 3,<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;apply_latency_ms&quot;: 0<br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }<br>
            <br>
            Device class information can be extracted of &quot;ceph df -f
            json-pretty&quot;.<br>
            <br>
            But building averages of averages not seems to be a good
            thing .... :-)<br>
            <br>
            It seems that i can get more detailed information using the
            &quot;ceph daemon<br>
            osd.&lt;nr&gt; perf histogram dump&quot; command.<br>
            This seems to deliver the percentile rank information in a
            good detail<br>
            level.<br>
            (<a href=3D"http://docs.ceph.com/docs/luminous/dev/perf_histogr=
ams/" rel=3D"noreferrer" target=3D"_blank">http://docs.ceph.com/docs/lum<wb=
r>inous/dev/perf_histograms/</a>)<br>
            <br>
            My questions:<br>
            <br>
            Are there tools to analyze and aggregate these measures for
            a group of OSDs?<br>
            <br>
            Which measures should i use as a baseline for client latency
            optimization?<br>
            <br>
            What is the time horizon of these measures?<br>
            <br>
            I sometimes see messages like this in my log.<br>
            This seems to be sourced in deep scrubbing. How can find the<br=
>
            source/solution of this problem?<br>
            <br>
            2018-07-11 16:58:55.064497 mon.ceph-mon-s43 [INF] Cluster is
            now healthy<br>
            2018-07-11 16:59:15.141214 mon.ceph-mon-s43 [WRN] Health
            check failed: 4<br>
            slow requests are blocked &gt; 32 sec (REQUEST_SLOW)<br>
            2018-07-11 16:59:25.037707 mon.ceph-mon-s43 [WRN] Health
            check update: 9<br>
            slow requests are blocked &gt; 32 sec (REQUEST_SLOW)<br>
            2018-07-11 16:59:30.038001 mon.ceph-mon-s43 [WRN] Health
            check update:<br>
            23 slow requests are blocked &gt; 32 sec (REQUEST_SLOW)<br>
            2018-07-11 16:59:35.210900 mon.ceph-mon-s43 [WRN] Health
            check update:<br>
            27 slow requests are blocked &gt; 32 sec (REQUEST_SLOW)<br>
            2018-07-11 16:59:45.038718 mon.ceph-mon-s43 [WRN] Health
            check update:<br>
            29 slow requests are blocked &gt; 32 sec (REQUEST_SLOW)<br>
            2018-07-11 16:59:50.038955 mon.ceph-mon-s43 [WRN] Health
            check update:<br>
            39 slow requests are blocked &gt; 32 sec (REQUEST_SLOW)<br>
            2018-07-11 16:59:55.281279 mon.ceph-mon-s43 [WRN] Health
            check update:<br>
            44 slow requests are blocked &gt; 32 sec (REQUEST_SLOW)<br>
            2018-07-11 17:00:00.000121 mon.ceph-mon-s43 [WRN] overall
            HEALTH_WARN 12<br>
            slow requests are blocked &gt; 32 sec<br>
            2018-07-11 17:00:05.039677 mon.ceph-mon-s43 [WRN] Health
            check update:<br>
            12 slow requests are blocked &gt; 32 sec (REQUEST_SLOW)<br>
            2018-07-11 17:00:09.329897 mon.ceph-mon-s43 [INF] Health
            check cleared:<br>
            REQUEST_SLOW (was: 12 slow requests are blocked &gt; 32 sec)<br=
>
            2018-07-11 17:00:09.329919 mon.ceph-mon-s43 [INF] Cluster is
            now healthy<br>
            <br>
            Regards<br>
            Marc<br>
            <br>
            <br>
            ______________________________<wbr>_________________<br>
            ceph-users mailing list<br>
            <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">=
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
            <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.c=
om" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr=
>.cgi/ceph-users-ceph.com</a><br>
          </blockquote>
        </div>
        <br>
        <br clear=3D"all">
        <br>
        -- <br>
        <div class=3D"gmail-m_-7622038527760407528gmail_signature">
          <div dir=3D"ltr">
            <div>
              <div dir=3D"ltr">
                <div>
                  <div dir=3D"ltr">Paul Emmerich<br>
                    <br>
                    Looking for help with your Ceph cluster? Contact us
                    at <a href=3D"https://croit.io" target=3D"_blank">https=
://croit.io</a><br>
                    <br>
                    croit GmbH<br>
                    <a href=3D"https://maps.google.com/?q=3DFreseniusstr.+3=
1h+%0D%0A++++++++++++++++++++81247+M%C3%BCnchen&amp;entry=3Dgmail&amp;sourc=
e=3Dg">Freseniusstr. 31h</a><br>
                    81247 M=C3=BCnchen<br>
                    <a href=3D"http://www.croit.io" target=3D"_blank">www.c=
roit.io</a><br>
                    Tel: +49 89 1896585 90<br>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </div></div></div>

</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">Paul E=
mmerich<br><br>Looking for help with your Ceph cluster? Contact us at <a hr=
ef=3D"https://croit.io" target=3D"_blank">https://croit.io</a><br><br>croit=
 GmbH<br>Freseniusstr. 31h<br>81247 M=C3=BCnchen<br><a href=3D"http://www.c=
roit.io" target=3D"_blank">www.croit.io</a><br>Tel: +49 89 1896585 90<br></=
div></div></div></div></div></div>
</div></div>

--00000000000052ff6d0570ccd214--

--===============1730858846808448779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1730858846808448779==--
