From: KIMURA Osamu <kimura.osamu@jp.fujitsu.com>
Subject: Re: rgw: multiple zonegroups in single realm
Date: Thu, 23 Feb 2017 20:34:54 +0900
Message-ID: <d6871268-0ebc-2b16-3eb1-402c331411a5@jp.fujitsu.com>
References: <bda40210-ac21-365e-d589-45360fca1920@jp.fujitsu.com>
 <CABo9giQ798Hvbm9EznFtK9UXVxArmfaCGxy3Ad_6zSA81ua1yw@mail.gmail.com>
 <856807cd-f398-1a88-f4da-ea08b6ef9694@jp.fujitsu.com>
 <CABo9giQauxSuE8W_w2Y1eREDOzSiHZjxqVzUUWsG5CyVkR82xg@mail.gmail.com>
 <6ea8ca76-3242-a2c3-9693-3c102a76f746@jp.fujitsu.com>
 <CABo9giQg5m3f-82RcnqnCt4_msiCfYVVHeB8At_5JyQHgMhwJg@mail.gmail.com>
 <66c9b74f-c46f-f1ac-30bb-3810415135d1@jp.fujitsu.com>
 <CABo9giSyqej4222EuVK1a93rHHPL9mGniFeyjyxhge_vxAWeSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:30431 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdBWLfX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 06:35:23 -0500
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
        by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id F2A26AC0165
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2017 20:35:16 +0900 (JST)
In-Reply-To: <CABo9giSyqej4222EuVK1a93rHHPL9mGniFeyjyxhge_vxAWeSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sorry to late.
I opened several tracker issues...

On 2017/02/15 16:53, Orit Wasserman wrote:
> On Wed, Feb 15, 2017 at 2:26 AM, KIMURA Osamu
> <kimura.osamu@jp.fujitsu.com> wrote:
>> Comments inline...
>>
>>
>> On 2017/02/14 23:54, Orit Wasserman wrote:
>>>
>>> On Mon, Feb 13, 2017 at 12:57 PM, KIMURA Osamu
>>> <kimura.osamu@jp.fujitsu.com> wrote:
>>>>
>>>> Hi Orit,
>>>>
>>>> I almost agree, with some exceptions...
>>>>
>>>>
>>>> On 2017/02/13 18:42, Orit Wasserman wrote:
>>>>>
>>>>>
>>>>> On Mon, Feb 13, 2017 at 6:44 AM, KIMURA Osamu
>>>>> <kimura.osamu@jp.fujitsu.com> wrote:
>>>>>>
>>>>>>
>>>>>> Hi Orit,
>>>>>>
>>>>>> Thanks for your comments.
>>>>>> I believe I'm not confusing, but probably my thought may not be well
>>>>>> described...
>>>>>>
>>>>> :)
>>>>>>
>>>>>> On 2017/02/12 19:07, Orit Wasserman wrote:
>>>>>>>
>>>>>>> On Fri, Feb 10, 2017 at 10:21 AM, KIMURA Osamu
>>>>>>> <kimura.osamu@jp.fujitsu.com> wrote:
>>>>>>>>
>>>>>>>> Hi Cephers,
>>>>>>>>
>>>>>>>> I'm trying to configure RGWs with multiple zonegroups within single
>>>>>>>> realm.
>>>>>>>> The intention is that some buckets to be replicated and others to
>>>>>>>> stay
>>>>>>>> locally.
>>>>>>>
>>>>>>>
>>>>>>> If you are not replicating than you don't need to create any zone
>>>>>>> configuration,
>>>>>>> a default zonegroup and zone are created automatically
>>>>>>>
>>>>>>>> e.g.:
>>>>>>>>  realm: fj
>>>>>>>>   zonegroup east: zone tokyo (not replicated)
>>>>>>>
>>>>>>>
>>>>>>> no need if not replicated
>>>>>>>>
>>>>>>>>   zonegroup west: zone osaka (not replicated)
>>>>>>>
>>>>>>>
>>>>>>> same here
>>>>>>>>
>>>>>>>>   zonegroup jp:   zone jp-east + jp-west (replicated)
>>>>>>
>>>>>>
>>>>>> The "east" and "west" zonegroups are just renamed from "default"
>>>>>> as described in RHCS document [3].
>>>>>
>>>>>
>>>>> Why do you need two zonegroups (or 3)?
>>>>>
>>>>> At the moment multisitev2 replicated automatically all zones in the
>>>>> realm except "default" zone.
>>>>> The moment you add a new zone (could be part of another zonegroup) it
>>>>> will be replicated to the other zones.
>>>>> It seems you don't want or need this.
>>>>> we are working on allowing more control on the replication but that
>>>>> will be in the future.
>>>>>
>>>>>> We may not need to rename them, but at least api_name should be
>>>>>> altered.
>>>>>
>>>>>
>>>>> You can change the api_name for the "default" zone.
>>>>>
>>>>>> In addition, I'm not sure what happens if 2 "default" zones/zonegroups
>>>>>> co-exist in same realm.
>>>>>
>>>>>
>>>>>
>>>>> Realm shares all the zones/zonegroups configuration,
>>>>> it means it is the same zone/zonegroup.
>>>>> For "default" it means not zone/zonegroup configured, we use it to run
>>>>> radosgw without any
>>>>> zone/zonegroup specified in the configuration.
>>>>
>>>>
>>>>
>>>> I didn't think "default" as exception of zonegroup. :-P
>>>> Actually, I must specify api_name in default zonegroup setting.
>>>>
>>>> I interpret "default" zone/zonegroup is out of realm. Is it correct?
>>>> I think it means namespace for bucket or user is not shared with
>>>> "default".
>>>> At present, I can't make decision to separate namespaces, but it may be
>>>> best choice with current code.

Unfortunately, if "api_name" is changed for "default" zonegroup,
the "default" zonegroup is set as a member of the realm.
See [19040-1]

It means no major difference from my first provided configuration.
(except reduction of messy error messages [15776] )

In addition, the "api_name" can't be changed with "radosgw-admin
zonegroup set" command if no realm has been defined.
There is no convenient way to change "api_name".

[19040-1]: http://tracker.ceph.com/issues/19040#note-1
[15776]: http://tracker.ceph.com/issues/15776

>>>>>>>> To evaluate such configuration, I tentatively built multiple
>>>>>>>> zonegroups
>>>>>>>> (east, west) on a ceph cluster. I barely succeed to configure it, but
>>>>>>>> some concerns exist.
>>>>>>>>
>>>>>>> I think you just need one zonegroup with two zones the other are not
>>>>>>> needed
>>>>>>> Also each gateway can handle only a single zone (rgw_zone
>>>>>>> configuration parameter)
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> This is just a tentative one to confirm the behavior of multiple
>>>>>> zonegroups
>>>>>> due to limitation of our current equipment.
>>>>>> The "east" zonegroup was renamed from "default", and another "west"
>>>>>> zonegroup
>>>>>> was created. Of course I specified both rgw_zonegroup and rgw_zone
>>>>>> parameters
>>>>>> for each RGW instance. (see -FYI- section bellow)
>>>>>>
>>>>> Can I suggest starting with a more simple setup:
>>>>> Two zonegroups,  the first will have two zones and the second will
>>>>> have one zone.
>>>>> It is simper to configure and in case of problems to debug.
>>>>
>>>>
>>>>
>>>> I would try with such configuration IF time permitted.

I tried. But it doesn't seem simpler :P
Because it consists 3 zonegroups and 4 zones.
I want to keep default zone/zonegroup.
The target system already has huge amount of objects.


>>>>>>>> a) User accounts are not synced among zonegroups

I opened 2 issues [19040] [19041]

[19040]: http://tracker.ceph.com/issues/19040
[19041]: http://tracker.ceph.com/issues/19041


>>>>>>>> I'm not sure if this is a issue, but the blueprint [1] stated a
>>>>>>>> master
>>>>>>>> zonegroup manages user accounts as metadata like buckets.
>>>>>>>>
>>>>>>> You have a lot of confusion with the zones and zonegroups.
>>>>>>> A zonegroup is just a group of zones that are sharing the same data
>>>>>>> (i.e. replication between them)
>>>>>>> A zone represent a geographical location (i.e. one ceph cluster)
>>>>>>>
>>>>>>> We have a meta master zone (the master zone in the master zonegroup),
>>>>>>> this meta master is responible on
>>>>>>> replicating users and byckets meta operations.
>>>>>>
>>>>>>
>>>>>> I know it.
>>>>>> But the master zone in the master zonegroup manages bucket meta
>>>>>> operations including buckets in other zonegroups. It means
>>>>>> the master zone in the master zonegroup must have permission to
>>>>>> handle buckets meta operations, i.e., must have same user accounts
>>>>>> as other zonegroups.
>>>>>
>>>>>
>>>>> Again zones not zonegroups,  it needs to have an admin user with the
>>>>> same credentials in all the other zones.
>>>>>
>>>>>> This is related to next issue b). If the master zone in the master
>>>>>> zonegroup doesn't have user accounts for other zonegroups, all the
>>>>>> buckets meta operations are rejected.
>>>>>>
>>>>>
>>>>> Correct
>>>>>
>>>>>> In addition, it may be overexplanation though, user accounts are
>>>>>> sync'ed to other zones within same zonegroup if the accounts are
>>>>>> created on master zone of the zonegroup. On the other hand,
>>>>>> I found today, user accounts are not sync'ed to master if the
>>>>>> accounts are created on slave(?) zone in the zonegroup. It seems
>>>>>> asymmetric behavior.
>>>>>
>>>>>
>>>>>
>>>>> This requires investigation,  can you open a tracker issue and we will
>>>>> look into it.
>>>>>
>>>>>> I'm not sure if the same behavior is caused by Admin REST API instead
>>>>>> of radosgw-admin.
>>>>>>
>>>>>
>>>>> It doesn't matter both use almost the same code
>>>>>
>>>>>>
>>>>>>>> b) Bucket creation is rejected if master zonegroup doesn't have the
>>>>>>>> account
>>>>>>>>
>>>>>>>> e.g.:
>>>>>>>>   1) Configure east zonegroup as master.
>>>>>>>
>>>>>>> you need a master zoen
>>>>>>>>
>>>>>>>>   2) Create a user "nishi" on west zonegroup (osaka zone) using
>>>>>>>> radosgw-admin.
>>>>>>>>   3) Try to create a bucket on west zonegroup by user nishi.
>>>>>>>>      -> ERROR: S3 error: 404 (NoSuchKey)
>>>>>>>>   4) Create user nishi on east zonegroup with same key.
>>>>>>>>   5) Succeed to create a bucket on west zonegroup by user nishi.
>>>>>>>
>>>>>>> You are confusing zonegroup and zone here again ...
>>>>>>>
>>>>>>> you should notice that when you are using radosgw-admin command
>>>>>>> without providing zonegorup and/or zone info (--rgw-zonegroup=<zg> and
>>>>>>> --rgw-zone=<zone>) it will use the default zonegroup and zone.
>>>>>>>
>>>>>>> User is stored per zone and you need to create an admin users in both
>>>>>>> zones
>>>>>>> for more documentation see:
>>>>>>> http://docs.ceph.com/docs/master/radosgw/multisite/
>>>>>>
>>>>>>
>>>>>> I always specify --rgw-zonegroup and --rgw-zone for radosgw-admin
>>>>>> command.
>>>>>>
>>>>> That is great!
>>>>> You can also onfigure default zone and zonegroup
>>>>>
>>>>>> The issue is that any buckets meta operations are rejected when the
>>>>>> master
>>>>>> zone in the master zonegroup doesn't have the user account of other
>>>>>> zonegroups.
>>>>>>
>>>>> Correct
>>>>>>
>>>>>>
>>>>>> I try to describe details again:
>>>>>> 1) Create fj realm as default.
>>>>>> 2) Rename default zonegroup/zone to east/tokyo and mark as default.
>>>>>> 3) Create west/osaka zonegroup/zone.
>>>>>> 4) Create system user sync-user on both tokyo and osaka zones with same
>>>>>> key.
>>>>>> 5) Start 2 RGW instances for tokyo and osaka zones.
>>>>>> 6) Create azuma user account on tokyo zone in east zonegroup.
>>>>>> 7) Create /bucket1 through tokyo zone endpoint with azuma account.
>>>>>>    -> No problem.
>>>>>> 8) Create nishi user account on osaka zone in west zonegroup.
>>>>>> 9) Try to create a bucket /bucket2 through osaka zone endpoint with
>>>>>> azuma
>>>>>> account.
>>>>>>    -> respond "ERROR: S3 error: 403 (InvalidAccessKeyId)" as expected.
>>>>>> 10) Try to create a bucket /bucket3 through osaka zone endpoint with
>>>>>> nishi
>>>>>> account.
>>>>>>    -> respond "ERROR: S3 error: 404 (NoSuchKey)"
>>>>>>    Detailed log is shown in -FYI- section bellow.
>>>>>>    The RGW for osaka zone verify the signature and forward the request
>>>>>>    to tokyo zone endpoint (= the master zone in the master zonegroup).
>>>>>>    Then, the RGW for tokyo zone rejected the request by unauthorized
>>>>>> access.
>>>>>>
>>>>>
>>>>> This seems a bug, can you open a issue?

I opened 2 issues [19042] [19043]

[19042]: http://tracker.ceph.com/issues/19042
[19043]: http://tracker.ceph.com/issues/19043

>>>>>>>> c) How to restrict to place buckets on specific zonegroups?
>>>>>>>
>>>>>>> you probably mean zone.
>>>>>>> There is ongoing work to enable/disable sync per bucket
>>>>>>> https://github.com/ceph/ceph/pull/10995
>>>>>>> with this you can create a bucket on a specific zone and it won't be
>>>>>>> replicated to another zone
>>>>>>
>>>>>>
>>>>>> My thought means zonegroup (not zone) as described above.
>>>>>
>>>>> But it should be zone ..
>>>>> Zone represent a geographical location , it represent a single ceph
>>>>> cluster.
>>>>> Bucket is created in a zone (a single ceph cluster) and it stored the
>>>>> zone
>>>>> id.
>>>>> The zone represent in which ceph cluster the bucket was created.
>>>>>
>>>>> A zonegroup just a logical collection of zones, in many case you only
>>>>> need a single zonegroup.
>>>>> You should use zonegroups if you have lots of zones and it simplifies
>>>>> your configuration.
>>>>> You can move zones between zonegroups (it is not tested or supported
>>>>> ...).
>>>>>
>>>>>> With current code, buckets are sync'ed to all zones within a zonegroup,
>>>>>> no way to choose zone to place specific buckets.
>>>>>> But this change may help to configure our original target.
>>>>>>
>>>>>> It seems we need more discussion about the change.
>>>>>> I prefer default behavior is associated with user account (per SLA).
>>>>>> And attribution of each bucket should be able to be changed via REST
>>>>>> API depending on their permission, rather than radosgw-admin command.
>>>>>>
>>>>>
>>>>> I think that will be very helpful , we need to understand what are the
>>>>> requirement and the usage.
>>>>> Please comment on the PR or even open a feature request and we can
>>>>> discuss it more in detail.
>>>>>
>>>>>> Anyway, I'll examine more details.
>>>>>>
>>>>>>>> If user accounts would synced future as the blueprint, all the
>>>>>>>> zonegroups
>>>>>>>> contain same account information. It means any user can create
>>>>>>>> buckets
>>>>>>>> on
>>>>>>>> any zonegroups. If we want to permit to place buckets on a replicated
>>>>>>>> zonegroup for specific users, how to configure?
>>>>>>>>
>>>>>>>> If user accounts will not synced as current behavior, we can restrict
>>>>>>>> to place buckets on specific zonegroups. But I cannot find best way
>>>>>>>> to
>>>>>>>> configure the master zonegroup.
>>>>>>>>
>>>>>>>>
>>>>>>>> d) Operations for other zonegroup are not redirected
>>>>>>>>
>>>>>>>> e.g.:
>>>>>>>>   1) Create bucket4 on west zonegroup by nishi.
>>>>>>>>   2) Try to access bucket4 from endpoint on east zonegroup.
>>>>>>>>      -> Respond "301 (Moved Permanently)",
>>>>>>>>         but no redirected Location header is returned.
>>>>>>>>
>>>>>>>
>>>>>>> It could be a bug please open a tracker issue for that in
>>>>>>> tracker.ceph.com for RGW component with all the configuration
>>>>>>> information,
>>>>>>> logs and the version of ceph and radosgw you are using.
>>>>>>
>>>>>>
>>>>>> I will open it, but it may be issued as "Feature" instead of "Bug"
>>>>>> depending on following discussion.

I opened an issue [19052] as "Feature" instead of "Bug".

[19052]: http://tracker.ceph.com/issues/19052

I suggested to use "hostnames" field in zonegroup configuration
for this purpose. I feel it is similar to s3 website feature.

>>>>>>>> It seems current RGW doesn't follows S3 specification [2].
>>>>>>>> To implement this feature, probably we need to define another
>>>>>>>> endpoint
>>>>>>>> on each zonegroup for client accessible URL. RGW may placed behind
>>>>>>>> proxy,
>>>>>>>> thus the URL may be different from endpoint URLs for replication.
>>>>>>>>
>>>>>>>
>>>>>>> The zone and zonegroup endpoints are not used directly by the user
>>>>>>> with
>>>>>>> a
>>>>>>> proxy.
>>>>>>> The user get a URL pointing to the proxy and the proxy will need to be
>>>>>>> configured to point the rgw urls/IPs , you can have several radosgw
>>>>>>> running.
>>>>>>> See more
>>>>>>>
>>>>>>> https://access.redhat.com/documentation/en/red-hat-ceph-storage/2/paged/object-gateway-guide-for-red-hat-enterprise-linux/chapter-2-configuration
>>>>>>
>>>>>> Does it mean the proxy has responsibility to alter "Location" header as
>>>>>> redirected URL?
>>>>>
>>>>> No
>>>>>
>>>>>> Basically, RGW can respond only the endpoint described in zonegroup
>>>>>> setting as redirected URL on Location header. But client may not access
>>>>>> the endpoint. Someone must translate the Location header to client
>>>>>> accessible URL.
>>>>>
>>>>> Both locations will have a proxy. This means all communication is done
>>>>> through proxies.
>>>>> The endpoint URL should be an external URL and the proxy on the new
>>>>> location will translate it to the internal one.
>>>>
>>>>
>>>>
>>>> Our assumption is:
>>>>
>>>> End-user client --- internet --- proxy ---+--- RGW site-A
>>>>                                           |
>>>>                                           | (dedicated line or VPN)
>>>>                                           |
>>>> End-user client --- internet --- proxy ---+--- RGW site-B
>>>>
>>>> RGWs can't access through front of proxies.
>>>> In this case, endpoints for replication are in backend network of
>>>> proxies.
>>>
>>>
>>> do you have several radosgw instances in each site?
>>
>>
>> Yes. Probably three or more instances per a site.
>> Actual system will have same number of physical servers as RGW instances.
>> We already tested with multiple endpoints per a zone within a zonegroup.
>
> Good to hear :)
> As for the redirect message in your case it's should to be handled by
> the proxy and not by the client browser
> as it cannot access the internal vpn network. The endpoints url should
> be the url in the internal network.

I don't agree.
It requires more network bandwidth between sites.
I think "hostnames" field provides client accessible URL
that is front of proxy. It seems sufficient.


In addition to above, I opened 2 issues [18800] [19053] regarding
Swift API, that are not related this discussion.

[18800]: http://tracker.ceph.com/issues/18800
[19053]: http://tracker.ceph.com/issues/19053


Regards,
KIMURA

> Orit
>>
>>>> How do you think?
>>>>
>>>>> Regards,
>>>>> Orit
>>>>>
>>>>>> If the proxy translates Location header, it looks like
>>>>>> man-in-the-middle
>>>>>> attack.
>>>>>>
>>>>>> Regards,
>>>>>> KIMURA
>>>>>>
>>>>>>> Regrads,
>>>>>>> Orit
>>>>>>>>
>>>>>>>> Any thoughts?
>>>>>>>
>>>>>>>>
>>>>>>>> [1] http://tracker.ceph.com/projects/ceph/wiki/Rgw_new_multisite_configuration
>>>>>>>> [2] http://docs.aws.amazon.com/AmazonS3/latest/dev/Redirects.html
>>>>>> [3] https://access.redhat.com/documentation/en/red-hat-ceph-storage/2/paged/object-gateway-guide-for-red-hat-enterprise-linux/chapter-8-multi-site#migrating_a_single_site_system_to_multi_site
>>>>>>
>>>>>>>> ------ FYI ------
>>>>>>>> [environments]
>>>>>>>> Ceph cluster: RHCS 2.0
>>>>>>>> RGW: RHEL 7.2 + RGW v10.2.5
>>>>>>>>
>>>>>>>> zonegroup east: master
>>>>>>>>  zone tokyo
>>>>>>>>   endpoint http://node5:80
>>>>>>        rgw frontends = "civetweb port=80"
>>>>>>        rgw zonegroup = east
>>>>>>        rgw zone = tokyo
>>>>>>>>
>>>>>>>>   system user: sync-user
>>>>>>>>   user azuma (+ nishi)
>>>>>>>>
>>>>>>>> zonegroup west: (not master)
>>>>>>>>   zone osaka
>>>>>>>>   endpoint http://node5:8081
>>>>>>        rgw frontends = "civetweb port=8081"
>>>>>>        rgw zonegroup = west
>>>>>>        rgw zone = osaka
>>>>>>
>>>>>>>>   system user: sync-user (created with same key as zone tokyo)
>>>>>>>>   user nishi

-- 
KIMURA Osamu / 木村 修
Engineering Department, Storage Development Division,
Data Center Platform Business Unit, FUJITSU LIMITED
