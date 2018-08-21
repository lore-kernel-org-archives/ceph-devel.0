From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: ceph balancer: further optimizations?
Date: Tue, 21 Aug 2018 12:07:20 +0200
Message-ID: <c4bee361-41c4-f589-91eb-4b58889f533a@profihost.ag>
References: <c83c7687-90da-bfbb-3d17-5af8bb897334@profihost.ag>
 <alpine.DEB.2.11.1808201951330.7272@piezo.novalocal>
 <95be32e6-a609-9e0f-1f75-dfcd3f876150@profihost.ag>
 <CABZ+qqnBTRJ0_owutqb57sM_+Ag9OZPd=g1Fq-9Q2+cJ3ddi3w@mail.gmail.com>
 <d0e31f59-9f69-24a2-b58e-96b5c836ccb1@profihost.ag>
 <CABZ+qqmonM8VBxjJ25W=rWmAX5rwWAKFy=JcuVrpnQsK1VrtPA@mail.gmail.com>
 <aff2c924-e66d-25ed-14e1-1ca41a258185@profihost.ag>
 <CABZ+qqnuX7W5gBregLrTw8p0gMUcbyRX-LqZfEv-aCPNBKg9RA@mail.gmail.com>
 <a85eb5ea-d239-42ed-009e-dffc8282678d@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <a85eb5ea-d239-42ed-009e-dffc8282678d-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


Am 21.08.2018 um 12:03 schrieb Stefan Priebe - Profihost AG:
> 
> Am 21.08.2018 um 11:56 schrieb Dan van der Ster:
>> On Tue, Aug 21, 2018 at 11:54 AM Stefan Priebe - Profihost AG
>> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>>>
>>> Am 21.08.2018 um 11:47 schrieb Dan van der Ster:
>>>> On Mon, Aug 20, 2018 at 10:45 PM Stefan Priebe - Profihost AG
>>>> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>>>>>
>>>>>
>>>>> Am 20.08.2018 um 22:38 schrieb Dan van der Ster:
>>>>>> On Mon, Aug 20, 2018 at 10:19 PM Stefan Priebe - Profihost AG
>>>>>> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>> Am 20.08.2018 um 21:52 schrieb Sage Weil:
>>>>>>>> On Mon, 20 Aug 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> since loic seems to have left ceph development and his wunderful crush
>>>>>>>>> optimization tool isn'T working anymore i'm trying to get a good
>>>>>>>>> distribution with the ceph balancer.
>>>>>>>>>
>>>>>>>>> Sadly it does not work as good as i want.
>>>>>>>>>
>>>>>>>>> # ceph osd df | sort -k8
>>>>>>>>>
>>>>>>>>> show 75 to 83% Usage which is 8% difference which is too much for me.
>>>>>>>>> I'm optimization by bytes.
>>>>>>>>>
>>>>>>>>> # ceph balancer eval
>>>>>>>>> current cluster score 0.005420 (lower is better)
>>>>>>>>>
>>>>>>>>> # ceph balancer eval $OPT_NAME
>>>>>>>>> plan spriebe_2018-08-20_19:36 final score 0.005456 (lower is better)
>>>>>>>>>
>>>>>>>>> I'm unable to optimize further ;-( Is there any chance to optimize
>>>>>>>>> further even in case of more rebelancing?
>>>>>>>>
>>>>>>>> The scoring that the balancer module is doing is currently a hybrid of pg
>>>>>>>> count, bytes, and object count.  Picking a single metric might help a bit
>>>>>>>> (as those 3 things are not always perfectly aligned).
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> ok i found a bug in the balancer code which seems to be present in all
>>>>>>> releases.
>>>>>>>
>>>>>>>  861                     best_ws = next_ws
>>>>>>>  862                     best_ow = next_ow
>>>>>>>
>>>>>>>
>>>>>>> should be:
>>>>>>>
>>>>>>>  861                     best_ws = copy.deepcopy(next_ws)
>>>>>>>  862                     best_ow = copy.deepcopy(next_ow)
>>>>>>>
>>>>>>> otherwise it does not use the best but the last.
>>>>>>
>>>>>> Interesting... does that change improve things?
>>>>>
>>>>> It fixes the following (mgr debug output):
>>>>> 2018-08-20 22:33:46.078525 7f2fbc3b6700  0 mgr[balancer] Step result
>>>>> score 0.001152 -> 0.001180, misplacing 0.000912
>>>>> 2018-08-20 22:33:46.078574 7f2fbc3b6700  0 mgr[balancer] Score got
>>>>> worse, taking another step
>>>>> 2018-08-20 22:33:46.078770 7f2fbc3b6700  0 mgr[balancer] Balancing root
>>>>> default (pools ['cephstor2']) by bytes
>>>>> 2018-08-20 22:33:46.156326 7f2fbc3b6700  0 mgr[balancer] Step result
>>>>> score 0.001152 -> 0.001180, misplacing 0.000912
>>>>> 2018-08-20 22:33:46.156374 7f2fbc3b6700  0 mgr[balancer] Score got
>>>>> worse, taking another step
>>>>> 2018-08-20 22:33:46.156581 7f2fbc3b6700  0 mgr[balancer] Balancing root
>>>>> default (pools ['cephstor2']) by bytes
>>>>> 2018-08-20 22:33:46.233818 7f2fbc3b6700  0 mgr[balancer] Step result
>>>>> score 0.001152 -> 0.001180, misplacing 0.000912
>>>>> 2018-08-20 22:33:46.233868 7f2fbc3b6700  0 mgr[balancer] Score got
>>>>> worse, taking another step
>>>>> 2018-08-20 22:33:46.234043 7f2fbc3b6700  0 mgr[balancer] Balancing root
>>>>> default (pools ['cephstor2']) by bytes
>>>>> 2018-08-20 22:33:46.313212 7f2fbc3b6700  0 mgr[balancer] Step result
>>>>> score 0.001152 -> 0.001180, misplacing 0.000912
>>>>> 2018-08-20 22:33:46.313714 7f2fbc3b6700  0 mgr[balancer] Score got
>>>>> worse, trying smaller step 0.000244
>>>>> 2018-08-20 22:33:46.313887 7f2fbc3b6700  0 mgr[balancer] Balancing root
>>>>> default (pools ['cephstor2']) by bytes
>>>>> 2018-08-20 22:33:46.391586 7f2fbc3b6700  0 mgr[balancer] Step result
>>>>> score 0.001152 -> 0.001152, misplacing 0.001141
>>>>> 2018-08-20 22:33:46.393374 7f2fbc3b6700  0 mgr[balancer] Balancing root
>>>>> default (pools ['cephstor2']) by bytes
>>>>> 2018-08-20 22:33:46.473956 7f2fbc3b6700  0 mgr[balancer] Step result
>>>>> score 0.001152 -> 0.001180, misplacing 0.000912
>>>>> 2018-08-20 22:33:46.474001 7f2fbc3b6700  0 mgr[balancer] Score got
>>>>> worse, taking another step
>>>>> 2018-08-20 22:33:46.474046 7f2fbc3b6700  0 mgr[balancer] Success, score
>>>>> 0.001155 -> 0.001152
>>>>>
>>>>> BUT:
>>>>> # ceph balancer eval myplan
>>>>> plan myplan final score 0.001180 (lower is better)
>>>>>
>>>>> So the final plan does NOT contain the expected optimization. The
>>>>> deepcopy fixes it.
>>>>>
>>>>> After:
>>>>> # ceph balancer eval myplan
>>>>> plan myplan final score 0.001152 (lower is better)
>>>>>
>>>>
>>>> OK that looks like a bug. Did you create a tracker or PR?
>>>
>>> No not yet. Should i create a PR on github with the fix?
>>
>> Yeah, probably tracker first (requesting luminous,mimic backports),
>> then a PR on master with "Fixes: tracker..."
> 
> Will do but can't find a create button in the tracker. I've opened
> several reports in the past but right now it seems a can't create a ticket.


http://tracker.ceph.com/projects/ceph/issues/new

=>

403
You are not authorized to access this page.




> Stefan
> 
>>
>> -- dan
>>
>>
>>>
>>>> -- Dan
>>>>
>>>>
>>>>>>
>>>>>> Also, if most of your data is in one pool you can try ceph balancer
>>>>>> eval <pool-name>
>>>>>
>>>>> Already tried this doesn't help much.
>>>>>
>>>>> Greets,
>>>>> Stefan
>>>>>
>>>>>
>>>>>> -- dan
>>>>>>
>>>>>>>
>>>>>>> I'm also using this one:
>>>>>>> https://github.com/ceph/ceph/pull/20665/commits/c161a74ad6cf006cd9b33b40fd7705b67c170615
>>>>>>>
>>>>>>> to optimize by bytes only.
>>>>>>>
>>>>>>> Greets,
>>>>>>> Stefan
