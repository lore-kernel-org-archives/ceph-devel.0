From: Daniel Gryniewicz <dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RGW lifecycle not expiring objects
Date: Mon, 5 Jun 2017 09:16:22 -0400
Message-ID: <3c3ff290-8032-1e03-dd82-eefd2ac01d34@redhat.com>
References: <CABGPr5nfykSv=ib6N_jMOarOF=O1XaPLxCXY6nNYR81wa62TBQ@mail.gmail.com>
	<CABGPr5=5y3NBJ_jGB1w=2=DeHU1GF4f7Ji+kTAJ_4f+O37hTFg@mail.gmail.com>
	<e19ebc5a-c8c1-eefb-acec-65fbc0284101@umn.edu>
	<trinity-9ef02e67-6909-42f8-ab06-a750a2bfab3c-1496441134227@3capp-gmx-bs48>
	<CADRKj5ShtTBA=_3e89jC-t31sArHZ=9Wfc5cA5VRHKFfd+gz0A@mail.gmail.com>
	<trinity-b11b03b1-bc6b-466e-ba26-77e1154d575f-1496604855693@3capp-gmx-bs77>
	<trinity-76fa44cc-8cd5-41f0-90e9-4a6d2e603ae6-1496617549501@3capp-gmx-bs31>
	<trinity-9ac6e555-43be-4a82-b5b5-e120d3af1e8b-1496617969363@3capp-gmx-bs31>
	<trinity-fe7badd9-ecbc-4d65-8fa0-231496938a25-1496618162797@3capp-gmx-bs31>
Reply-To: dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <trinity-fe7badd9-ecbc-4d65-8fa0-231496938a25-1496618162797@3capp-gmx-bs31>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org, Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Kraken has lifecycle, Jewel does not.

Daniel

On 06/04/2017 07:16 PM, ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org wrote:
>
> grrr... sorry && and again as text :|
>
>
> Gesendet: Montag, 05. Juni 2017 um 01:12 Uhr
> Von: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
> An: "Yehuda Sadeh-Weinraub" <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Betreff: Re: [ceph-users] RGW lifecycle not expiring objects
>
>
>
> Hi (again) Yehuda.
>
> Looping in ceph-devel...
>
> Could it be that lifecycle is still not implemented neither in Jewel nor in Kraken, even if release notes and other places say so?
>
> https://www.spinics.net/lists/ceph-devel/msg34492.html
> https://github.com/ceph/ceph-ci/commit/7d48f62f5c86913d8f00b44d46a04a52d338907c
> https://github.com/ceph/ceph-ci/commit/9162bd29594d34429a09562ed60a32a0703940ea
>
> Thanks & regards
>  Anton
>
>
> Gesendet: Sonntag, 04. Juni 2017 um 21:34 Uhr
> Von: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
> An: "Yehuda Sadeh-Weinraub" <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Betreff: Re: [ceph-users] RGW lifecycle not expiring objects
> Hi Yahuda.
>
> Well, here we go: http://tracker.ceph.com/issues/20177[http://tracker.ceph.com/issues/20177]
>
> As it's my first one, hope it's ok as it is...
>
> Thanks & regards
> Anton
>
>
> Gesendet: Samstag, 03. Juni 2017 um 00:14 Uhr
> Von: "Yehuda Sadeh-Weinraub" <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> An: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
> Cc: "Graham Allan" <gta-OJFnDUYgAso@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Betreff: Re: [ceph-users] RGW lifecycle not expiring objects
> Have you opened a ceph tracker issue, so that we don't lose track of
> the problem?
>
> Thanks,
> Yehuda
>
> On Fri, Jun 2, 2017 at 3:05 PM, <ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org> wrote:
>> Hi Graham.
>>
>> We are on Kraken and have the same problem with "lifecycle". Various (other) tools like s3cmd or CyberDuck do show the applied "expiration" settings, but objects seem never to be purged.
>>
>> If you should have new findings, hints,... PLEASE share/let me know.
>>
>> Thanks a lot!
>> Anton
>>
>>
>> Gesendet: Freitag, 19. Mai 2017 um 22:44 Uhr
>> Von: "Graham Allan" <gta-OJFnDUYgAso@public.gmane.org>
>> An: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> Betreff: [ceph-users] RGW lifecycle not expiring objects
>> I've been having a hard time getting the s3 object lifecycle to do
>> anything here. I was able to set a lifecycle on a test bucket. As others
>> also seem to have found, I do get an EACCES error on setting the
>> lifecycle, but it does however get stored:
>>
>>> % aws --endpoint-url https://xxx.xxx.xxx.xxx[https://xxx.xxx.xxx.xxx][https://xxx.xxx.xxx.xxx[https://xxx.xxx.xxx.xxx]] s3api get-bucket-lifecycle-configuration --bucket=testgta
>>> {
>>> "Rules": [
>>> {
>>> "Status": "Enabled",
>>> "Prefix": "",
>>> "Expiration": {
>>> "Days": 3
>>> },
>>> "ID": "test"
>>> }
>>> ]
>>> }
>>
>> but many days later I have yet to see any object actually get expired.
>> There are some hints in the rgw log that the expiry thread does run
>> periodically:
>>
>>> 2017-05-19 03:49:03.281347 7f74f1134700 2 RGWDataChangesLog::ChangesRenewThread: start
>>> 2017-05-19 03:49:16.356022 7f74ef931700 2 object expiration: start
>>> 2017-05-19 03:49:16.356036 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000000
>>> 2017-05-19 03:49:16.359785 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000001
>>> 2017-05-19 03:49:16.364667 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000002
>>> 2017-05-19 03:49:16.369636 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000003
>> ...
>>> 2017-05-19 03:49:16.803270 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000126
>>> 2017-05-19 03:49:16.806423 7f74ef931700 2 object expiration: stop
>>
>> "radosgw-admin lc process" gives me no output unless I enable debug, then:
>>
>>> ]# radosgw-admin lc process
>>> 2017-05-19 15:28:46.383049 7fedb9ffb700 2 RGWDataChangesLog::ChangesRenewThread: start
>>> 2017-05-19 15:28:46.421806 7feddc240c80 10 Cannot find current period zone using local zone
>>> 2017-05-19 15:28:46.453431 7feddc240c80 2 all 8 watchers are set, enabling cache
>>> 2017-05-19 15:28:46.614991 7feddc240c80 2 removed watcher, disabling cache
>>
>> "radosgw-admin lc list" seems to return "empty" output:
>>
>>> # radosgw-admin lc list
>>> []
>>
>> Is there anything obvious that I might be missing?
>>
>> Graham
>> --
>> Graham Allan
>> Minnesota Supercomputing Institute - gta-OJFnDUYgAso@public.gmane.org
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.cep
 h.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]]]
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]]
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]
>
>  _______________________________________________ ceph-users mailing list ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
