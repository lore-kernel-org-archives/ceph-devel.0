From: KIMURA Osamu <kimura.osamu@jp.fujitsu.com>
Subject: Re: rgw: multiple zonegroups in single realm
Date: Mon, 13 Feb 2017 13:44:49 +0900
Message-ID: <856807cd-f398-1a88-f4da-ea08b6ef9694@jp.fujitsu.com>
References: <bda40210-ac21-365e-d589-45360fca1920@jp.fujitsu.com>
 <CABo9giQ798Hvbm9EznFtK9UXVxArmfaCGxy3Ad_6zSA81ua1yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:38844 "EHLO
        mgwym03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdBME4U (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Feb 2017 23:56:20 -0500
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
        by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id DBD37AC00AA
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 13:45:00 +0900 (JST)
In-Reply-To: <CABo9giQ798Hvbm9EznFtK9UXVxArmfaCGxy3Ad_6zSA81ua1yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Orit,

Thanks for your comments.
I believe I'm not confusing, but probably my thought may not be well described...

On 2017/02/12 19:07, Orit Wasserman wrote:
> On Fri, Feb 10, 2017 at 10:21 AM, KIMURA Osamu
> <kimura.osamu@jp.fujitsu.com> wrote:
>> Hi Cephers,
>>
>> I'm trying to configure RGWs with multiple zonegroups within single realm.
>> The intention is that some buckets to be replicated and others to stay
>> locally.
>
> If you are not replicating than you don't need to create any zone configuration,
> a default zonegroup and zone are created automatically
>
>> e.g.:
>>  realm: fj
>>   zonegroup east: zone tokyo (not replicated)
> no need if not replicated
>>   zonegroup west: zone osaka (not replicated)
> same here
>>   zonegroup jp:   zone jp-east + jp-west (replicated)

The "east" and "west" zonegroups are just renamed from "default"
as described in RHCS document [3].
We may not need to rename them, but at least api_name should be altered.
In addition, I'm not sure what happens if 2 "default" zones/zonegroups
co-exist in same realm.


>> To evaluate such configuration, I tentatively built multiple zonegroups
>> (east, west) on a ceph cluster. I barely succeed to configure it, but
>> some concerns exist.
>>
> I think you just need one zonegroup with two zones the other are not needed
> Also each gateway can handle only a single zone (rgw_zone
> configuration parameter)

This is just a tentative one to confirm the behavior of multiple zonegroups
due to limitation of our current equipment.
The "east" zonegroup was renamed from "default", and another "west" zonegroup
was created. Of course I specified both rgw_zonegroup and rgw_zone parameters
for each RGW instance. (see -FYI- section bellow)


>> a) User accounts are not synced among zonegroups
>>
>> I'm not sure if this is a issue, but the blueprint [1] stated a master
>> zonegroup manages user accounts as metadata like buckets.
>>
> You have a lot of confusion with the zones and zonegroups.
> A zonegroup is just a group of zones that are sharing the same data
> (i.e. replication between them)
> A zone represent a geographical location (i.e. one ceph cluster)
>
> We have a meta master zone (the master zone in the master zonegroup),
> this meta master is responible on
> replicating users and byckets meta operations.

I know it.
But the master zone in the master zonegroup manages bucket meta
operations including buckets in other zonegroups. It means
the master zone in the master zonegroup must have permission to
handle buckets meta operations, i.e., must have same user accounts
as other zonegroups.
This is related to next issue b). If the master zone in the master
zonegroup doesn't have user accounts for other zonegroups, all the
buckets meta operations are rejected.

In addition, it may be overexplanation though, user accounts are
sync'ed to other zones within same zonegroup if the accounts are
created on master zone of the zonegroup. On the other hand,
I found today, user accounts are not sync'ed to master if the
accounts are created on slave(?) zone in the zonegroup. It seems
asymmetric behavior.
I'm not sure if the same behavior is caused by Admin REST API instead
of radosgw-admin.


>> b) Bucket creation is rejected if master zonegroup doesn't have the account
>>
>> e.g.:
>>   1) Configure east zonegroup as master.
> you need a master zoen
>>   2) Create a user "nishi" on west zonegroup (osaka zone) using
>> radosgw-admin.
>>   3) Try to create a bucket on west zonegroup by user nishi.
>>      -> ERROR: S3 error: 404 (NoSuchKey)
>>   4) Create user nishi on east zonegroup with same key.
>>   5) Succeed to create a bucket on west zonegroup by user nishi.
>>
>
> You are confusing zonegroup and zone here again ...
>
> you should notice that when you are using radosgw-admin command
> without providing zonegorup and/or zone info (--rgw-zonegroup=<zg> and
> --rgw-zone=<zone>) it will use the default zonegroup and zone.
>
> User is stored per zone and you need to create an admin users in both zones
> for more documentation see: http://docs.ceph.com/docs/master/radosgw/multisite/

I always specify --rgw-zonegroup and --rgw-zone for radosgw-admin command.

The issue is that any buckets meta operations are rejected when the master
zone in the master zonegroup doesn't have the user account of other zonegroups.

I try to describe details again:
1) Create fj realm as default.
2) Rename default zonegroup/zone to east/tokyo and mark as default.
3) Create west/osaka zonegroup/zone.
4) Create system user sync-user on both tokyo and osaka zones with same key.
5) Start 2 RGW instances for tokyo and osaka zones.
6) Create azuma user account on tokyo zone in east zonegroup.
7) Create /bucket1 through tokyo zone endpoint with azuma account.
    -> No problem.
8) Create nishi user account on osaka zone in west zonegroup.
9) Try to create a bucket /bucket2 through osaka zone endpoint with azuma account.
    -> respond "ERROR: S3 error: 403 (InvalidAccessKeyId)" as expected.
10) Try to create a bucket /bucket3 through osaka zone endpoint with nishi account.
    -> respond "ERROR: S3 error: 404 (NoSuchKey)"
    Detailed log is shown in -FYI- section bellow.
    The RGW for osaka zone verify the signature and forward the request
    to tokyo zone endpoint (= the master zone in the master zonegroup).
    Then, the RGW for tokyo zone rejected the request by unauthorized access.


>> c) How to restrict to place buckets on specific zonegroups?
>>
>
> you probably mean zone.
> There is ongoing work to enable/disable sync per bucket
> https://github.com/ceph/ceph/pull/10995
> with this you can create a bucket on a specific zone and it won't be
> replicated to another zone

My thought means zonegroup (not zone) as described above.
With current code, buckets are sync'ed to all zones within a zonegroup,
no way to choose zone to place specific buckets.
But this change may help to configure our original target.

It seems we need more discussion about the change.
I prefer default behavior is associated with user account (per SLA).
And attribution of each bucket should be able to be changed via REST
API depending on their permission, rather than radosgw-admin command.

Anyway, I'll examine more details.

>> If user accounts would synced future as the blueprint, all the zonegroups
>> contain same account information. It means any user can create buckets on
>> any zonegroups. If we want to permit to place buckets on a replicated
>> zonegroup for specific users, how to configure?
>>
>> If user accounts will not synced as current behavior, we can restrict
>> to place buckets on specific zonegroups. But I cannot find best way to
>> configure the master zonegroup.
>>
>>
>> d) Operations for other zonegroup are not redirected
>>
>> e.g.:
>>   1) Create bucket4 on west zonegroup by nishi.
>>   2) Try to access bucket4 from endpoint on east zonegroup.
>>      -> Respond "301 (Moved Permanently)",
>>         but no redirected Location header is returned.
>>
>
> It could be a bug please open a tracker issue for that in
> tracker.ceph.com for RGW component with all the configuration
> information,
> logs and the version of ceph and radosgw you are using.

I will open it, but it may be issued as "Feature" instead of "Bug"
depending on following discussion.

>> It seems current RGW doesn't follows S3 specification [2].
>> To implement this feature, probably we need to define another endpoint
>> on each zonegroup for client accessible URL. RGW may placed behind proxy,
>> thus the URL may be different from endpoint URLs for replication.
>>
>
> The zone and zonegroup endpoints are not used directly by the user with a proxy.
> The user get a URL pointing to the proxy and the proxy will need to be
> configured to point the rgw urls/IPs , you can have several radosgw
> running.
> See more https://access.redhat.com/documentation/en/red-hat-ceph-storage/2/paged/object-gateway-guide-for-red-hat-enterprise-linux/chapter-2-configuration

Does it mean the proxy has responsibility to alter "Location" header as
redirected URL?

Basically, RGW can respond only the endpoint described in zonegroup
setting as redirected URL on Location header. But client may not access
the endpoint. Someone must translate the Location header to client
accessible URL.

If the proxy translates Location header, it looks like man-in-the-middle
attack.


Regards,
KIMURA

> Regrads,
> Orit
>>
>> Any thoughts?
>
>>
>> [1]
>> http://tracker.ceph.com/projects/ceph/wiki/Rgw_new_multisite_configuration
>> [2] http://docs.aws.amazon.com/AmazonS3/latest/dev/Redirects.html

[3] https://access.redhat.com/documentation/en/red-hat-ceph-storage/2/paged/object-gateway-guide-for-red-hat-enterprise-linux/chapter-8-multi-site#migrating_a_single_site_system_to_multi_site

>> ------ FYI ------
>> [environments]
>> Ceph cluster: RHCS 2.0
>> RGW: RHEL 7.2 + RGW v10.2.5
>>
>> zonegroup east: master
>>  zone tokyo
>>   endpoint http://node5:80
        rgw frontends = "civetweb port=80"
        rgw zonegroup = east
        rgw zone = tokyo
>>   system user: sync-user
>>   user azuma (+ nishi)
>>
>> zonegroup west: (not master)
>>   zone osaka
>>   endpoint http://node5:8081
        rgw frontends = "civetweb port=8081"
        rgw zonegroup = west
        rgw zone = osaka
>>   system user: sync-user (created with same key as zone tokyo)
>>   user nishi
>>
>>
>> [detail of "b)"]
>>
>> $ s3cmd -c s3nishi.cfg ls
>> $ s3cmd -c s3nishi.cfg mb s3://bucket3
>> ERROR: S3 error: 404 (NoSuchKey)
>>
>> ---- rgw.osaka log:
>> 2017-02-10 11:54:13.290653 7feac3f7f700  1 ====== starting new request
>> req=0x7feac3f79710 =====
>> 2017-02-10 11:54:13.290709 7feac3f7f700  2 req 50:0.000057::PUT
>> /bucket3/::initializing for trans_id =
>> tx000000000000000000032-00589d2b55-14a2-osaka
>> 2017-02-10 11:54:13.290720 7feac3f7f700 10 rgw api priority: s3=5
>> s3website=4
>> 2017-02-10 11:54:13.290722 7feac3f7f700 10 host=node5
>> 2017-02-10 11:54:13.290733 7feac3f7f700 10 meta>> HTTP_X_AMZ_CONTENT_SHA256
>> 2017-02-10 11:54:13.290750 7feac3f7f700 10 meta>> HTTP_X_AMZ_DATE
>> 2017-02-10 11:54:13.290753 7feac3f7f700 10 x>>
>> x-amz-content-sha256:d8f96fbdf666b991d183a7f5cc7fcf6eaa10934786f67575bda3f734a772464a
>> 2017-02-10 11:54:13.290755 7feac3f7f700 10 x>> x-amz-date:20170210T025413Z
>> 2017-02-10 11:54:13.290774 7feac3f7f700 10
>> handler=25RGWHandler_REST_Bucket_S3
>> 2017-02-10 11:54:13.290775 7feac3f7f700  2 req 50:0.000124:s3:PUT
>> /bucket3/::getting op 1
>> 2017-02-10 11:54:13.290781 7feac3f7f700 10 op=27RGWCreateBucket_ObjStore_S3
>> 2017-02-10 11:54:13.290782 7feac3f7f700  2 req 50:0.000130:s3:PUT
>> /bucket3/:create_bucket:authorizing
>> 2017-02-10 11:54:13.290798 7feac3f7f700 10 v4 signature format =
>> 989404f270efd800843cb19183c53dc457cf96b9ea2393ba5d554a42ffc22f76
>> 2017-02-10 11:54:13.290804 7feac3f7f700 10 v4 credential format =
>> ZY6EJUVB38SCOWBELERQ/20170210/west/s3/aws4_request
>> 2017-02-10 11:54:13.290806 7feac3f7f700 10 access key id =
>> ZY6EJUVB38SCOWBELERQ
>> 2017-02-10 11:54:13.290814 7feac3f7f700 10 credential scope =
>> 20170210/west/s3/aws4_request
>> 2017-02-10 11:54:13.290834 7feac3f7f700 10 canonical headers format =
>> host:node5:8081
>> x-amz-content-sha256:d8f96fbdf666b991d183a7f5cc7fcf6eaa10934786f67575bda3f734a772464a
>> x-amz-date:20170210T025413Z
>>
>> 2017-02-10 11:54:13.290836 7feac3f7f700 10 delaying v4 auth
>> 2017-02-10 11:54:13.290839 7feac3f7f700  2 req 50:0.000187:s3:PUT
>> /bucket3/:create_bucket:normalizing buckets and tenants
>> 2017-02-10 11:54:13.290841 7feac3f7f700 10 s->object=<NULL>
>> s->bucket=bucket3
>> 2017-02-10 11:54:13.290843 7feac3f7f700  2 req 50:0.000191:s3:PUT
>> /bucket3/:create_bucket:init permissions
>> 2017-02-10 11:54:13.290844 7feac3f7f700  2 req 50:0.000192:s3:PUT
>> /bucket3/:create_bucket:recalculating target
>> 2017-02-10 11:54:13.290845 7feac3f7f700  2 req 50:0.000193:s3:PUT
>> /bucket3/:create_bucket:reading permissions
>> 2017-02-10 11:54:13.290846 7feac3f7f700  2 req 50:0.000195:s3:PUT
>> /bucket3/:create_bucket:init op
>> 2017-02-10 11:54:13.290847 7feac3f7f700  2 req 50:0.000196:s3:PUT
>> /bucket3/:create_bucket:verifying op mask
>> 2017-02-10 11:54:13.290849 7feac3f7f700  2 req 50:0.000197:s3:PUT
>> /bucket3/:create_bucket:verifying op permissions
>> 2017-02-10 11:54:13.292027 7feac3f7f700  2 req 50:0.001374:s3:PUT
>> /bucket3/:create_bucket:verifying op params
>> 2017-02-10 11:54:13.292035 7feac3f7f700  2 req 50:0.001383:s3:PUT
>> /bucket3/:create_bucket:pre-executing
>> 2017-02-10 11:54:13.292037 7feac3f7f700  2 req 50:0.001385:s3:PUT
>> /bucket3/:create_bucket:executing
>> 2017-02-10 11:54:13.292072 7feac3f7f700 10 payload request hash =
>> d8f96fbdf666b991d183a7f5cc7fcf6eaa10934786f67575bda3f734a772464a
>> 2017-02-10 11:54:13.292083 7feac3f7f700 10 canonical request = PUT
>> /bucket3/
>>
>> host:node5:8081
>> x-amz-content-sha256:d8f96fbdf666b991d183a7f5cc7fcf6eaa10934786f67575bda3f734a772464a
>> x-amz-date:20170210T025413Z
>>
>> host;x-amz-content-sha256;x-amz-date
>> d8f96fbdf666b991d183a7f5cc7fcf6eaa10934786f67575bda3f734a772464a
>> 2017-02-10 11:54:13.292084 7feac3f7f700 10 canonical request hash =
>> 8faa5ec57f69dd7b54baa72c157b6d63f8c7db309a34a1e2a10ad6f2f585cd02
>> 2017-02-10 11:54:13.292087 7feac3f7f700 10 string to sign = AWS4-HMAC-SHA256
>> 20170210T025413Z
>> 20170210/west/s3/aws4_request
>> 8faa5ec57f69dd7b54baa72c157b6d63f8c7db309a34a1e2a10ad6f2f585cd02
>> 2017-02-10 11:54:13.292118 7feac3f7f700 10 date_k        =
>> 454f3ad73c095e73d2482809d7a6ec8af3c4e900bc83e0a9663ea5fc336cad95
>> 2017-02-10 11:54:13.292131 7feac3f7f700 10 region_k      =
>> e0caaddbb30ebc25840b6aaac3979d1881a14b8e9a0dfea43d8a006c8e0e504d
>> 2017-02-10 11:54:13.292144 7feac3f7f700 10 service_k     =
>> 59d6c9158e9e3c6a1aa97ee15859d2ef9ad9c64209b63f093109844f0c7f6c04
>> 2017-02-10 11:54:13.292171 7feac3f7f700 10 signing_k     =
>> 4dcbccd9c3da779d32758a645644c66a56f64d642eaeb39eec8e0b2facba7805
>> 2017-02-10 11:54:13.292197 7feac3f7f700 10 signature_k   =
>> 989404f270efd800843cb19183c53dc457cf96b9ea2393ba5d554a42ffc22f76
>> 2017-02-10 11:54:13.292198 7feac3f7f700 10 new signature =
>> 989404f270efd800843cb19183c53dc457cf96b9ea2393ba5d554a42ffc22f76
>> 2017-02-10 11:54:13.292199 7feac3f7f700 10 -----------------------------
>> Verifying signatures
>> 2017-02-10 11:54:13.292199 7feac3f7f700 10 Signature     =
>> 989404f270efd800843cb19183c53dc457cf96b9ea2393ba5d554a42ffc22f76
>> 2017-02-10 11:54:13.292200 7feac3f7f700 10 New Signature =
>> 989404f270efd800843cb19183c53dc457cf96b9ea2393ba5d554a42ffc22f76
>> 2017-02-10 11:54:13.292200 7feac3f7f700 10 -----------------------------
>> 2017-02-10 11:54:13.292202 7feac3f7f700 10 v4 auth ok
>> 2017-02-10 11:54:13.292238 7feac3f7f700 10 create bucket location
>> constraint: west
>> 2017-02-10 11:54:13.292256 7feac3f7f700 10 cache get:
>> name=osaka.rgw.data.root+bucket3 : type miss (requested=22, cached=0)
>> 2017-02-10 11:54:13.293369 7feac3f7f700 10 cache put:
>> name=osaka.rgw.data.root+bucket3 info.flags=0
>> 2017-02-10 11:54:13.293374 7feac3f7f700 10 moving
>> osaka.rgw.data.root+bucket3 to cache LRU end
>> 2017-02-10 11:54:13.293380 7feac3f7f700  0 sending create_bucket request to
>> master zonegroup
>> 2017-02-10 11:54:13.293401 7feac3f7f700 10 get_canon_resource():
>> dest=/bucket3/
>> 2017-02-10 11:54:13.293403 7feac3f7f700 10 generated canonical header: PUT
>>
>>
>> Fri Feb 10 02:54:13 2017
>> x-amz-content-sha256:d8f96fbdf666b991d183a7f5cc7fcf6eaa10934786f67575bda3f734a772464a
>> /bucket3/
>> 2017-02-10 11:54:13.299113 7feac3f7f700 10 receive_http_header
>> 2017-02-10 11:54:13.299117 7feac3f7f700 10 received header:HTTP/1.1 404 Not
>> Found
>> 2017-02-10 11:54:13.299119 7feac3f7f700 10 receive_http_header
>> 2017-02-10 11:54:13.299120 7feac3f7f700 10 received header:x-amz-request-id:
>> tx000000000000000000005-00589d2b55-1416-tokyo
>> 2017-02-10 11:54:13.299130 7feac3f7f700 10 receive_http_header
>> 2017-02-10 11:54:13.299131 7feac3f7f700 10 received header:Content-Length:
>> 175
>> 2017-02-10 11:54:13.299133 7feac3f7f700 10 receive_http_header
>> 2017-02-10 11:54:13.299133 7feac3f7f700 10 received header:Accept-Ranges:
>> bytes
>> 2017-02-10 11:54:13.299148 7feac3f7f700 10 receive_http_header
>> 2017-02-10 11:54:13.299149 7feac3f7f700 10 received header:Content-Type:
>> application/xml
>> 2017-02-10 11:54:13.299150 7feac3f7f700 10 receive_http_header
>> 2017-02-10 11:54:13.299150 7feac3f7f700 10 received header:Date: Fri, 10 Feb
>> 2017 02:54:13 GMT
>> 2017-02-10 11:54:13.299152 7feac3f7f700 10 receive_http_header
>> 2017-02-10 11:54:13.299152 7feac3f7f700 10 received header:
>> 2017-02-10 11:54:13.299248 7feac3f7f700  2 req 50:0.008596:s3:PUT
>> /bucket3/:create_bucket:completing
>> 2017-02-10 11:54:13.299319 7feac3f7f700  2 req 50:0.008667:s3:PUT
>> /bucket3/:create_bucket:op status=-2
>> 2017-02-10 11:54:13.299321 7feac3f7f700  2 req 50:0.008670:s3:PUT
>> /bucket3/:create_bucket:http status=404
>> 2017-02-10 11:54:13.299324 7feac3f7f700  1 ====== req done
>> req=0x7feac3f79710 op status=-2 http_status=404 ======
>> 2017-02-10 11:54:13.299349 7feac3f7f700  1 civetweb: 0x7feb2c02d340:
>> 192.168.20.15 - - [10/Feb/2017:11:54:13 +0900] "PUT /bucket3/ HTTP/1.1" 404
>> 0 - -
>>
>>
>> ---- rgw.tokyo log:
>> 2017-02-10 11:54:13.297852 7f56076c6700  1 ====== starting new request
>> req=0x7f56076c0710 =====
>> 2017-02-10 11:54:13.297887 7f56076c6700  2 req 5:0.000035::PUT
>> /bucket3/::initializing for trans_id =
>> tx000000000000000000005-00589d2b55-1416-tokyo
>> 2017-02-10 11:54:13.297895 7f56076c6700 10 rgw api priority: s3=5
>> s3website=4
>> 2017-02-10 11:54:13.297897 7f56076c6700 10 host=node5
>> 2017-02-10 11:54:13.297906 7f56076c6700 10 meta>> HTTP_X_AMZ_CONTENT_SHA256
>> 2017-02-10 11:54:13.297912 7f56076c6700 10 x>>
>> x-amz-content-sha256:d8f96fbdf666b991d183a7f5cc7fcf6eaa10934786f67575bda3f734a772464a
>> 2017-02-10 11:54:13.297929 7f56076c6700 10
>> handler=25RGWHandler_REST_Bucket_S3
>> 2017-02-10 11:54:13.297937 7f56076c6700  2 req 5:0.000086:s3:PUT
>> /bucket3/::getting op 1
>> 2017-02-10 11:54:13.297946 7f56076c6700 10 op=27RGWCreateBucket_ObjStore_S3
>> 2017-02-10 11:54:13.297947 7f56076c6700  2 req 5:0.000096:s3:PUT
>> /bucket3/:create_bucket:authorizing
>> 2017-02-10 11:54:13.297969 7f56076c6700 10 get_canon_resource():
>> dest=/bucket3/
>> 2017-02-10 11:54:13.297976 7f56076c6700 10 auth_hdr:
>> PUT
>>
>>
>> Fri Feb 10 02:54:13 2017
>> x-amz-content-sha256:d8f96fbdf666b991d183a7f5cc7fcf6eaa10934786f67575bda3f734a772464a
>> /bucket3/
>> 2017-02-10 11:54:13.298023 7f56076c6700 10 cache get:
>> name=default.rgw.users.uid+nishi : type miss (requested=6, cached=0)
>> 2017-02-10 11:54:13.298975 7f56076c6700 10 cache put:
>> name=default.rgw.users.uid+nishi info.flags=0
>> 2017-02-10 11:54:13.298986 7f56076c6700 10 moving
>> default.rgw.users.uid+nishi to cache LRU end
>> 2017-02-10 11:54:13.298991 7f56076c6700  0 User lookup failed!
>> 2017-02-10 11:54:13.298993 7f56076c6700 10 failed to authorize request
>> 2017-02-10 11:54:13.299077 7f56076c6700  2 req 5:0.001225:s3:PUT
>> /bucket3/:create_bucket:op status=0
>> 2017-02-10 11:54:13.299086 7f56076c6700  2 req 5:0.001235:s3:PUT
>> /bucket3/:create_bucket:http status=404
>> 2017-02-10 11:54:13.299089 7f56076c6700  1 ====== req done
>> req=0x7f56076c0710 op status=0 http_status=404 ======
>> 2017-02-10 11:54:13.299426 7f56076c6700  1 civetweb: 0x7f56200048c0:
>> 192.168.20.15 - - [10/Feb/2017:11:54:13 +0900] "PUT /bucket3/ HTTP/1.1" 404
>> 0 - -

-- 
KIMURA Osamu / 木村 修
Engineering Department, Storage Development Division,
Data Center Platform Business Unit, FUJITSU LIMITED
