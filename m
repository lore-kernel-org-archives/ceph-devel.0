From: "Anton Oks" <anton.oks@gmx.de>
Subject: Aw: Re: [ceph-users] RGW lifecycle not expiring objects
Date: Mon, 5 Jun 2017 01:05:49 +0200
Message-ID: <trinity-76fa44cc-8cd5-41f0-90e9-4a6d2e603ae6-1496617549501@3capp-gmx-bs31>
References: <CABGPr5nfykSv=ib6N_jMOarOF=O1XaPLxCXY6nNYR81wa62TBQ@mail.gmail.com>
 <CABGPr5=5y3NBJ_jGB1w=2=DeHU1GF4f7Ji+kTAJ_4f+O37hTFg@mail.gmail.com>
 <e19ebc5a-c8c1-eefb-acec-65fbc0284101@umn.edu>
 <trinity-9ef02e67-6909-42f8-ab06-a750a2bfab3c-1496441134227@3capp-gmx-bs48>
 <CADRKj5ShtTBA=_3e89jC-t31sArHZ=9Wfc5cA5VRHKFfd+gz0A@mail.gmail.com>
 <trinity-b11b03b1-bc6b-466e-ba26-77e1154d575f-1496604855693@3capp-gmx-bs77>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:56594 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdFDXGO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 4 Jun 2017 19:06:14 -0400
In-Reply-To: <trinity-b11b03b1-bc6b-466e-ba26-77e1154d575f-1496604855693@3capp-gmx-bs77>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org


Hi (again) Yehuda.

Looping in ceph-devel...
 
Could it be that lifecycle is still not implemented in Jewel and/or Kraken, even if the release notes and other places say so?
 
https://www.spinics.net/lists/ceph-devel/msg34492.html
https://github.com/ceph/ceph-ci/commit/7d48f62f5c86913d8f00b44d46a04a52d338907c
https://github.com/ceph/ceph-ci/commit/9162bd29594d34429a09562ed60a32a0703940ea
 
Thanks & regards
 Anton
 

Gesendet: Sonntag, 04. Juni 2017 um 21:34 Uhr
Von: ceph.novice@habmalnefrage.de
An: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
Betreff: Re: [ceph-users] RGW lifecycle not expiring objects
Hi Yahuda.

Well, here we go: http://tracker.ceph.com/issues/20177

As it's my first one, hope it's ok as it is...

Thanks & regards
Anton


Gesendet: Samstag, 03. Juni 2017 um 00:14 Uhr
Von: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
An: ceph.novice@habmalnefrage.de
Cc: "Graham Allan" <gta@umn.edu>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
Betreff: Re: [ceph-users] RGW lifecycle not expiring objects
Have you opened a ceph tracker issue, so that we don't lose track of
the problem?

Thanks,
Yehuda

On Fri, Jun 2, 2017 at 3:05 PM, <ceph.novice@habmalnefrage.de> wrote:
> Hi Graham.
>
> We are on Kraken and have the same problem with "lifecycle". Various (other) tools like s3cmd or CyberDuck do show the applied "expiration" settings, but objects seem never to be purged.
>
> If you should have new findings, hints,... PLEASE share/let me know.
>
> Thanks a lot!
> Anton
>
>
> Gesendet: Freitag, 19. Mai 2017 um 22:44 Uhr
> Von: "Graham Allan" <gta@umn.edu>
> An: ceph-users@lists.ceph.com
> Betreff: [ceph-users] RGW lifecycle not expiring objects
> I've been having a hard time getting the s3 object lifecycle to do
> anything here. I was able to set a lifecycle on a test bucket. As others
> also seem to have found, I do get an EACCES error on setting the
> lifecycle, but it does however get stored:
>
>> % aws --endpoint-url https://xxx.xxx.xxx.xxx[https://xxx.xxx.xxx.xxx] s3api get-bucket-lifecycle-configuration --bucket=testgta
>> {
>> "Rules": [
>> {
>> "Status": "Enabled",
>> "Prefix": "",
>> "Expiration": {
>> "Days": 3
>> },
>> "ID": "test"
>> }
>> ]
>> }
>
> but many days later I have yet to see any object actually get expired.
> There are some hints in the rgw log that the expiry thread does run
> periodically:
>
>> 2017-05-19 03:49:03.281347 7f74f1134700 2 RGWDataChangesLog::ChangesRenewThread: start
>> 2017-05-19 03:49:16.356022 7f74ef931700 2 object expiration: start
>> 2017-05-19 03:49:16.356036 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000000
>> 2017-05-19 03:49:16.359785 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000001
>> 2017-05-19 03:49:16.364667 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000002
>> 2017-05-19 03:49:16.369636 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000003
> ...
>> 2017-05-19 03:49:16.803270 7f74ef931700 20 proceeding shard = obj_delete_at_hint.0000000126
>> 2017-05-19 03:49:16.806423 7f74ef931700 2 object expiration: stop
>
> "radosgw-admin lc process" gives me no output unless I enable debug, then:
>
>> ]# radosgw-admin lc process
>> 2017-05-19 15:28:46.383049 7fedb9ffb700 2 RGWDataChangesLog::ChangesRenewThread: start
>> 2017-05-19 15:28:46.421806 7feddc240c80 10 Cannot find current period zone using local zone
>> 2017-05-19 15:28:46.453431 7feddc240c80 2 all 8 watchers are set, enabling cache
>> 2017-05-19 15:28:46.614991 7feddc240c80 2 removed watcher, disabling cache
>
> "radosgw-admin lc list" seems to return "empty" output:
>
>> # radosgw-admin lc list
>> []
>
> Is there anything obvious that I might be missing?
>
> Graham
> --
> Graham Allan
> Minnesota Supercomputing Institute - gta@umn.edu
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]]
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com][http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]]
_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]
