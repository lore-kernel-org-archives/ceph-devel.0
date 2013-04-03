From: Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
Subject: Re: Cluster Map Problems
Date: Wed, 03 Apr 2013 16:32:22 +0200
Message-ID: <515C3D76.1060302@tuxadero.com>
References: <514B5958.8050902@tuxadero.com> <51539550.70806@tuxadero.com>
	<CAM2gkg7h59X1u0L7P2Z9er+da3OoMw2Tmdbf=afWbUy8gKi+tA@mail.gmail.com>
	<5153A218.1060402@tuxadero.com>
	<CABZ+qq=LYqOC0o1S4-7iR-L2XweRQuBL6maoVz3LXwKKrJ90gg@mail.gmail.com>
	<51542952.3020502@tuxadero.com>
	<CAPYLRzhd2zLEQM=hgfLQWF5snSMn=NX=71b5kN+AYspAD24Q-g@mail.gmail.com>
	<51547F73.9090303@tuxadero.com>
	<CAPYLRzjeb5qeJGkeP+vxuWjwmh2KufKfJW8nMc7fVRPm+b3MHw@mail.gmail.com>
	<515483CA.2080904@tuxadero.com>
	<CAPYLRzi_CvAjEGYof=eWZ+9z3fC6hjfAyhPQ1fxgc2CNqYNsaA@mail.gmail.com>
	<51548810.709@tuxadero.com>
	<CAM2gkg7z3i9gzdo-ceDSJ5kZ_xhif7QieKLoS1YpvtbPt9w4PA@mail.gmail.com>
	<51549AF3.3080903@tuxadero.com>
	<CAPYLRzgyr5M8aWbtpdCn4ge6zcmgPS2k91k5-t4PyEiTernGaQ@mail.gmail.com>
	<5154A267.4010207@tuxadero.com>
	<CAM2gkg4fLE_N4kXdVX_2_suAy8-EuK=4ZTT0xqB0znjzYEB_5Q@mail.gmail.com>
	<5154C339.7070705@tuxadero.com>
	<CAM2gkg628PRNUye9poNJZ+fMNUpgRL=6CwoEXg6y=TqbtY3YhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAM2gkg628PRNUye9poNJZ+fMNUpgRL=6CwoEXg6y=TqbtY3YhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: John Wilkins <john.wilkins-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

I still have this problem in v0.60.
If I stop one OSD, the OSD get set down after 20 seconds. But after 300
seconds the OSD get not set out, there for the ceph stays degraded for ever.
I can reproduce it with a fresh created cluster.

root@store1:~# ceph -s
   health HEALTH_WARN 405 pgs degraded; 405 pgs stuck unclean; recovery
10603/259576 degraded (4.085%); 1/24 in osds are down
   monmap e1: 3 mons at
{a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
election epoch 10, quorum 0,1,2 a,b,c
   osdmap e150: 24 osds: 23 up, 24 in
    pgmap v12028: 4800 pgs: 4395 active+clean, 405 active+degraded; 505
GB data, 1017 GB used, 173 TB / 174 TB avail; 0B/s rd, 6303B/s wr,
2op/s; 10603/259576 degraded (4.085%)
   mdsmap e1: 0/0/1 up


-martin


On 28.03.2013 23:45, John Wilkins wrote:
> Martin,
> 
> I'm just speculating: since I just rewrote the networking section and
> there is an empty mon_host value, and I do recall a chat last week
> where mon_host was considered a different setting now, maybe you might
> try specifying:
> 
> [mon.a]
>         mon host = store1
>         mon addr = 192.168.195.31:6789
> 
> etc. for monitors. I'm assuming that's not the case, but I want to
> make sure my docs are right on this point.
> 
> 
> On Thu, Mar 28, 2013 at 3:24 PM, Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org> wrote:
>> Hi John,
>>
>> my ceph.conf is a bit further down in this email.
>>
>> -martin
>>
>> Am 28.03.2013 23:21, schrieb John Wilkins:
>>
>>> Martin,
>>>
>>> Would you mind posting your Ceph configuration file too?  I don't see
>>> any value set for "mon_host": ""
>>>
>>> On Thu, Mar 28, 2013 at 1:04 PM, Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
>>> wrote:
>>>>
>>>> Hi Greg,
>>>>
>>>> the dump from mon.a is attached.
>>>>
>>>> -martin
>>>>
>>>> On 28.03.2013 20:55, Gregory Farnum wrote:
>>>>>
>>>>> Hmm. The monitor code for checking this all looks good to me. Can you
>>>>> go to one of your monitor nodes and dump the config?
>>>>>
>>>>> (http://ceph.com/docs/master/rados/configuration/ceph-conf/?highlight=admin%20socket#viewing-a-configuration-at-runtime)
>>>>> -Greg
>>>>>
>>>>> On Thu, Mar 28, 2013 at 12:33 PM, Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
>>>>> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I get the same behavior an new created cluster as well, no changes to
>>>>>> the cluster config at all.
>>>>>> I stop the osd.1, after 20 seconds it got marked down. But it never get
>>>>>> marked out.
>>>>>>
>>>>>> ceph version 0.59 (cbae6a435c62899f857775f66659de052fb0e759)
>>>>>>
>>>>>> -martin
>>>>>>
>>>>>> On 28.03.2013 19:48, John Wilkins wrote:
>>>>>>>
>>>>>>> Martin,
>>>>>>>
>>>>>>> Greg is talking about noout. With Ceph, you can specifically preclude
>>>>>>> OSDs from being marked out when down to prevent rebalancing--e.g.,
>>>>>>> during upgrades, short-term maintenance, etc.
>>>>>>>
>>>>>>>
>>>>>>> http://ceph.com/docs/master/rados/operations/troubleshooting-osd/#stopping-w-out-rebalancing
>>>>>>>
>>>>>>> On Thu, Mar 28, 2013 at 11:12 AM, Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Hi Greg,
>>>>>>>>
>>>>>>>> setting the osd manually out triggered the recovery.
>>>>>>>> But now it is the question, why is the osd not marked out after 300
>>>>>>>> seconds? That's a default cluster, I use the 0.59 build from your
>>>>>>>> site.
>>>>>>>> And I didn't change any value, except for the crushmap.
>>>>>>>>
>>>>>>>> That's my ceph.conf.
>>>>>>>>
>>>>>>>> -martin
>>>>>>>>
>>>>>>>> [global]
>>>>>>>>          auth cluster requierd = none
>>>>>>>>          auth service required = none
>>>>>>>>          auth client required = none
>>>>>>>> #       log file = ""
>>>>>>>>          log_max_recent=100
>>>>>>>>          log_max_new=100
>>>>>>>>
>>>>>>>> [mon]
>>>>>>>>          mon data = /data/mon.$id
>>>>>>>> [mon.a]
>>>>>>>>          host = store1
>>>>>>>>          mon addr = 192.168.195.31:6789
>>>>>>>> [mon.b]
>>>>>>>>          host = store3
>>>>>>>>          mon addr = 192.168.195.33:6789
>>>>>>>> [mon.c]
>>>>>>>>          host = store5
>>>>>>>>          mon addr = 192.168.195.35:6789
>>>>>>>> [osd]
>>>>>>>>          journal aio = true
>>>>>>>>          osd data = /data/osd.$id
>>>>>>>>          osd mount options btrfs = rw,noatime,nodiratime,autodefrag
>>>>>>>>          osd mkfs options btrfs = -n 32k -l 32k
>>>>>>>>
>>>>>>>> [osd.0]
>>>>>>>>          host = store1
>>>>>>>>          osd journal = /dev/sdg1
>>>>>>>>          btrfs devs = /dev/sdc
>>>>>>>> [osd.1]
>>>>>>>>          host = store1
>>>>>>>>          osd journal = /dev/sdh1
>>>>>>>>          btrfs devs = /dev/sdd
>>>>>>>> [osd.2]
>>>>>>>>          host = store1
>>>>>>>>          osd journal = /dev/sdi1
>>>>>>>>          btrfs devs = /dev/sde
>>>>>>>> [osd.3]
>>>>>>>>          host = store1
>>>>>>>>          osd journal = /dev/sdj1
>>>>>>>>          btrfs devs = /dev/sdf
>>>>>>>> [osd.4]
>>>>>>>>          host = store2
>>>>>>>>          osd journal = /dev/sdg1
>>>>>>>>          btrfs devs = /dev/sdc
>>>>>>>> [osd.5]
>>>>>>>>          host = store2
>>>>>>>>          osd journal = /dev/sdh1
>>>>>>>>          btrfs devs = /dev/sdd
>>>>>>>> [osd.6]
>>>>>>>>          host = store2
>>>>>>>>          osd journal = /dev/sdi1
>>>>>>>>          btrfs devs = /dev/sde
>>>>>>>> [osd.7]
>>>>>>>>          host = store2
>>>>>>>>          osd journal = /dev/sdj1
>>>>>>>>          btrfs devs = /dev/sdf
>>>>>>>> [osd.8]
>>>>>>>>          host = store3
>>>>>>>>          osd journal = /dev/sdg1
>>>>>>>>          btrfs devs = /dev/sdc
>>>>>>>> [osd.9]
>>>>>>>>          host = store3
>>>>>>>>          osd journal = /dev/sdh1
>>>>>>>>          btrfs devs = /dev/sdd
>>>>>>>> [osd.10]
>>>>>>>>          host = store3
>>>>>>>>          osd journal = /dev/sdi1
>>>>>>>>          btrfs devs = /dev/sde
>>>>>>>> [osd.11]
>>>>>>>>          host = store3
>>>>>>>>          osd journal = /dev/sdj1
>>>>>>>>          btrfs devs = /dev/sdf
>>>>>>>> [osd.12]
>>>>>>>>          host = store4
>>>>>>>>          osd journal = /dev/sdg1
>>>>>>>>          btrfs devs = /dev/sdc
>>>>>>>> [osd.13]
>>>>>>>>          host = store4
>>>>>>>>          osd journal = /dev/sdh1
>>>>>>>>          btrfs devs = /dev/sdd
>>>>>>>> [osd.14]
>>>>>>>>          host = store4
>>>>>>>>          osd journal = /dev/sdi1
>>>>>>>>          btrfs devs = /dev/sde
>>>>>>>> [osd.15]
>>>>>>>>          host = store4
>>>>>>>>          osd journal = /dev/sdj1
>>>>>>>>          btrfs devs = /dev/sdf
>>>>>>>> [osd.16]
>>>>>>>>          host = store5
>>>>>>>>          osd journal = /dev/sdg1
>>>>>>>>          btrfs devs = /dev/sdc
>>>>>>>> [osd.17]
>>>>>>>>          host = store5
>>>>>>>>          osd journal = /dev/sdh1
>>>>>>>>          btrfs devs = /dev/sdd
>>>>>>>> [osd.18]
>>>>>>>>          host = store5
>>>>>>>>          osd journal = /dev/sdi1
>>>>>>>>          btrfs devs = /dev/sde
>>>>>>>> [osd.19]
>>>>>>>>          host = store5
>>>>>>>>          osd journal = /dev/sdj1
>>>>>>>>          btrfs devs = /dev/sdf
>>>>>>>> [osd.20]
>>>>>>>>          host = store6
>>>>>>>>          osd journal = /dev/sdg1
>>>>>>>>          btrfs devs = /dev/sdc
>>>>>>>> [osd.21]
>>>>>>>>          host = store6
>>>>>>>>          osd journal = /dev/sdh1
>>>>>>>>          btrfs devs = /dev/sdd
>>>>>>>> [osd.22]
>>>>>>>>          host = store6
>>>>>>>>          osd journal = /dev/sdi1
>>>>>>>>          btrfs devs = /dev/sde
>>>>>>>> [osd.23]
>>>>>>>>          host = store6
>>>>>>>>          osd journal = /dev/sdj1
>>>>>>>>          btrfs devs = /dev/sdf
>>>>>>>>
>>>>>>>>
>>>>>>>> On 28.03.2013 19:01, Gregory Farnum wrote:
>>>>>>>>>
>>>>>>>>> Your crush map looks fine to me. I'm saying that your ceph -s output
>>>>>>>>> showed the OSD still hadn't been marked out. No data will be
>>>>>>>>> migrated
>>>>>>>>> until it's marked out.
>>>>>>>>> After ten minutes it should have been marked out, but that's based
>>>>>>>>> on
>>>>>>>>> a number of factors you have some control over. If you just want a
>>>>>>>>> quick check of your crush map you can mark it out manually, too.
>>>>>>>>> -Greg
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> ceph-users mailing list
>>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>
>>>
>>>
>>
> 
> 
> 
