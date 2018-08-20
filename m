From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: ceph balancer: further optimizations?
Date: Mon, 20 Aug 2018 22:18:55 +0200
Message-ID: <95be32e6-a609-9e0f-1f75-dfcd3f876150@profihost.ag>
References: <c83c7687-90da-bfbb-3d17-5af8bb897334@profihost.ag>
 <alpine.DEB.2.11.1808201951330.7272@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1808201951330.7272-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


Am 20.08.2018 um 21:52 schrieb Sage Weil:
> On Mon, 20 Aug 2018, Stefan Priebe - Profihost AG wrote:
>> Hello,
>>
>> since loic seems to have left ceph development and his wunderful crush
>> optimization tool isn'T working anymore i'm trying to get a good
>> distribution with the ceph balancer.
>>
>> Sadly it does not work as good as i want.
>>
>> # ceph osd df | sort -k8
>>
>> show 75 to 83% Usage which is 8% difference which is too much for me.
>> I'm optimization by bytes.
>>
>> # ceph balancer eval
>> current cluster score 0.005420 (lower is better)
>>
>> # ceph balancer eval $OPT_NAME
>> plan spriebe_2018-08-20_19:36 final score 0.005456 (lower is better)
>>
>> I'm unable to optimize further ;-( Is there any chance to optimize
>> further even in case of more rebelancing?
> 
> The scoring that the balancer module is doing is currently a hybrid of pg 
> count, bytes, and object count.  Picking a single metric might help a bit 
> (as those 3 things are not always perfectly aligned).

Hi,

ok i found a bug in the balancer code which seems to be present in all
releases.

 861                     best_ws = next_ws
 862                     best_ow = next_ow


should be:

 861                     best_ws = copy.deepcopy(next_ws)
 862                     best_ow = copy.deepcopy(next_ow)

otherwise it does not use the best but the last.

I'm also using this one:
https://github.com/ceph/ceph/pull/20665/commits/c161a74ad6cf006cd9b33b40fd7705b67c170615

to optimize by bytes only.

Greets,
Stefan
