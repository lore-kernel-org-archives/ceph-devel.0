From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Ceph-deploy refuses to create a named daemon
Date: Wed, 22 Apr 2015 09:24:14 -0400
Message-ID: <CACkq2mrafdPPpA2-AAU=pnpP7DBevr_qvgshouxxzsYksWuvsw@mail.gmail.com>
References: <552B38F9.5020506@catalyst.net.nz> <55375EFA.2030600@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33980 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756630AbbDVNYf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Apr 2015 09:24:35 -0400
Received: by qkgx75 with SMTP id x75so220668900qkg.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2015 06:24:34 -0700 (PDT)
In-Reply-To: <55375EFA.2030600@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

Thanks for the detective work!  I'll confirm whether the constraint on
the client name is really intended -- I believe that it is.  Once
confirmed, I completely agree that ceph-deploy should not allow you to
create rgw daemons with names that we know Ceph is going to reject.

 - Travis

On Wed, Apr 22, 2015 at 4:42 AM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> On 13/04/15 15:33, Mark Kirkwood wrote:
>>
>> Hi,
>>
>> I've been experimenting with the new rgw creation in ceph-deploy, using
>> version 1.5.23 together with ceph 0.94 (-948-gd77de49).
>>
>> If simply run it without any args, then it works fine. e.g:
>>
>>
>> $ ceph-deploy  rgw create ceph1
>>
>>
>> However if I try to set a name for the daemon:
>>
>>
>> $ ceph-deploy  rgw create ceph1:radosgw.ceph1
>>
>>
>> then it fails to create and start a radosgw daemon at all. Poking
>> through the logs I see:
>>
>> $ tail ceph-client.radosgw.ceph1.log
>> 2015-04-13 14:13:20.513860 7f7e36c04840  0 librados:
>> client.radosgw.ceph1 authentication error (1) Operation not permitted
>>
>>
>> Not terribly informative. Looking at the audit log:
>>
>> $ tail ceph.audit.log
>> 015-04-13 15:10:37.880085 mon.0 192.168.122.21:6789/0 147 : audit [INF]
>> from='client.? 192.168.122.22:0/1004669' entity='client.bootstrap-rgw'
>> cmd=[{"prefix": "auth get-or-create", "entity": "client.radosgw.ceph2",
>> "caps": ["osd", "allow rwx", "mon", "allow rw"]}]:  access denied
>>
>>
>> Looking at what ceph-deploy is doing I see that the failing command is:
>>
>>
>> $ sudo ceph --cluster ceph --name client.bootstrap-rgw --keyring
>> /var/lib/ceph/bootstrap-rgw/ceph.keyring auth get-or-create
>> client.radosgw.ceph2 osd 'allow rwx' mon 'allow rw' -o
>> /var/lib/ceph/radosgw/ceph-radosgw.ceph2/keyring
>>
>>
>> This is failing whereas the equivalent command with radosgw replaced by
>> rgw works. Looking at what privileges client.bootstrap-rgw has I see:
>>
>> $ sudo ceph auth get client.bootstrap-rgw
>> [client.bootstrap-rgw]
>>      key = XXXXXXXXXXXXXXXXXX==
>>      caps mon = "allow profile bootstrap-rgw"
>>
>> Ah, so need to look at how the profile bootstrap-rgw is setup:
>>
>> $ more src/mon/MonCap.cc
>> ...
>>    if (profile == "bootstrap-rgw") {
>>      profile_grants.push_back(MonCapGrant("mon", MON_CAP_R));  // read
>> monmap
>>      profile_grants.push_back(MonCapGrant("osd", MON_CAP_R));  // read
>> osdmap
>>      profile_grants.push_back(MonCapGrant("mon getmap"));
>>      profile_grants.push_back(MonCapGrant("auth get-or-create"));  //
>> FIXME: this can expose other mds keys
>>      profile_grants.back().command_args["entity"] = StringConstraint("",
>> "client.rgw.");           <======
>>      profile_grants.back().command_args["caps_mon"] =
>> StringConstraint("allow rw", "");
>>      profile_grants.back().command_args["caps_osd"] =
>> StringConstraint("allow rwx", "");
>>    }
>> ...
>>
>> I see - the ["entity"] check requires the name to match "client.rgw.".
>> Double checking back on the deployed host (ceph1), I see that:
>>
>>
>> $ ceph --cluster ceph --name client.bootstrap-rgw --keyring
>> /var/lib/ceph/bootstrap-rgw/ceph.keyring auth get-or-create
>> client.rgw.ceph3 osd 'allow rwx' mon 'allow rw'
>> [client.rgw.ceph3]
>>      key = AQCrNytVp9bqFBAAgTJVQDVQFJqiSkFqD68XsQ==
>> $ ceph --cluster ceph --name client.bootstrap-rgw --keyring
>> /var/lib/ceph/bootstrap-rgw/ceph.keyring auth get-or-create
>> client.radosgw.ceph3 osd 'allow rwx' mon 'allow rw'
>> Error EACCES: access denied
>>
>> Ok so that is definitely the problem.
>>
>> Is this restriction intended? If so we really should make ceph-deploy
>> aware of this...as it is a bit of a foot gun (and not as easy as I made
>> it seem above to figure out *why* the deploy didn't work).
>>
>> Cheers
>>
>> Mark
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> ping?
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
