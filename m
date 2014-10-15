From: Alphe Salas <asalas-g2h0fw6BmCNmR6Xm/wNWPw@public.gmane.org>
Subject: Re: the state of cephfs in giant
Date: Wed, 15 Oct 2014 13:47:40 -0300
Message-ID: <543EA52C.6080804@kepler.cl>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
	<543CD16C.6060708@m-privacy.de>
	<alpine.DEB.2.00.1410140718050.10462@cobra.newdream.net>
	<543E179E.4070704@m-privacy.de> <543E645E.4080405@redhat.com>
	<543E7315.6010300@m-privacy.de>
	<alpine.DEB.2.00.1410150754560.10462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1410150754560.10462-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Amon Ott <a.ott-oFjU9DtLk10Mb+B85CZM8Q@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

For the humble ceph user I am it is really hard to follow what version 
of what product will get the changes I requiere.

Let me explain myself. I use ceph in my company is specialised in disk 
recovery, my company needs a flexible, easy to maintain, trustable way 
to store the data from the disks of our clients.

We try the usual way jbod boxes connected to a single server with a SAS 
raid card and ZFS mirror to handle replicas and merging disks into a big 
disk. result is really slow. (used to use zfs and solaris 11 on x86 
servers... with openZfs and ubuntu 14.04 the perf are way better but not 
any were comparable with ceph (on a giga ethernet lan you can get data 
transfer betwin client and ceph cluster around 80MB/s...while client to 
openzfs/ubuntu is around 25MB/S)

Along my path with ceph I first used cephfs, worked fine! until I 
noticed that part of the folder tree suddently randomly disapeared 
forcing a constant periodical remount of the partitions.

Then I choose to forget about cephfs and use rbd images, worked fine!
Until I noticed that rbd replicas where never freed or overwriten and 
that for a replicas set to 2 (data and 1 replica) and an image of 13 TB 
after some time of write erase cycles on the same rbd image I get an 
overall data use of 34 TB over the 36TB available on my cluster I 
noticed that there was a real problem with "space management". The data 
part of the rbd image was properly managed using overwrites on old 
deleted data at OS level, so the only logical explaination of the 
overall data use growth was that the replicas where never freed.

All along that time I was pending of the bugs/ features and advances of 
ceph.
But those isues are not really ceph related they are kernel modules for 
using "ceph clients" so the release of feature add and bug fix are in 
part to be given in the ceph-common package (for the server related 
machanics) and the other part is then to be provided at the kernel level.

For comodity I use Ubuntu which is not really top notch using the very 
lastest brew of the kernel and all the bug fixed modules.

So when I see this great news about giant and the fact that alot of work 
has been done in solving most of the problems we all faced with
ceph then I notice that it will be around a year or so for those fix to 
be production available in ubuntu. There is some inertia there that 
doesn t match with the pace of the work on ceph.

Then people can arg with me "why you use ubuntu?"
and the answers are simple I have a cluster of 10 machines and 1 proxy 
if I need to compile from source lastest brew of ceph and lastest brew 
of kernel then my maintainance time will be way bigger. And I am more 
intended to get something that isn t properly done and have a machine 
that doesn t reboot.
I know what I am talking about I used during several month ceph in 
archlinux compiling kernel and ceph from source until the gcc installed 
on my test server was too new and a compile option had been removed then 
ceph wasn t compiling. That way to proceed was descarted because not 
stable enough to bring production level quality.

So as far as I understand things I will have cephfs enhanced and rbd 
discard ability available at same time using the couple ceph giant and 
linux kernel 3.18 and up ?

regards and thank you again for your hardwork, I wish I could do more to 
help.


---
Alphe Salas
I.T ingeneer

On 10/15/2014 11:58 AM, Sage Weil wrote:
> On Wed, 15 Oct 2014, Amon Ott wrote:
>> Am 15.10.2014 14:11, schrieb Ric Wheeler:
>>> On 10/15/2014 08:43 AM, Amon Ott wrote:
>>>> Am 14.10.2014 16:23, schrieb Sage Weil:
>>>>> On Tue, 14 Oct 2014, Amon Ott wrote:
>>>>>> Am 13.10.2014 20:16, schrieb Sage Weil:
>>>>>>> We've been doing a lot of work on CephFS over the past few months.
>>>>>>> This
>>>>>>> is an update on the current state of things as of Giant.
>>>>>> ...
>>>>>>> * Either the kernel client (kernel 3.17 or later) or userspace
>>>>>>> (ceph-fuse
>>>>>>>     or libcephfs) clients are in good working order.
>>>>>> Thanks for all the work and specially for concentrating on CephFS! We
>>>>>> have been watching and testing for years by now and really hope to
>>>>>> change our Clusters to CephFS soon.
>>>>>>
>>>>>> For kernel maintenance reasons, we only want to run longterm stable
>>>>>> kernels. And for performance reasons and because of severe known
>>>>>> problems we want to avoid Fuse. How good are our chances of a stable
>>>>>> system with the kernel client in the latest longterm kernel 3.14? Will
>>>>>> there be further bugfixes or feature backports?
>>>>> There are important bug fixes missing from 3.14.  IIRC, the EC, cache
>>>>> tiering, and firefly CRUSH changes aren't there yet either (they
>>>>> landed in
>>>>> 3.15), and that is not appropriate for a stable series.
>>>>>
>>>>> They can be backported, but no commitment yet on that :)
>>>> If the bugfixes are easily identified in one of your Ceph git branches,
>>>> I would even try to backport them myself. Still, I would rather see
>>>> someone from the Ceph team with deeper knowledge of the code port them.
>>>>
>>>> IMHO, it would be good for Ceph to have stable support in at least the
>>>> latest longterm kernel. No need for new features, but bugfixes should be
>>>> there.
>>>>
>>>> Amon Ott
>>>
>>> Long term support and aggressive, tedious backports are what you go to
>>> distro vendors for normally - I don't think that it is generally a good
>>> practice to continually backport anything to stable series kernels that
>>> is not a bugfix/security issue (or else, the stable branches rapidly
>>> just a stale version of the upstream tip :)).
>>
>> bugfix/security is exactly what I am looking for.
>
> Right; sorry if I was unclear.  We make a point of sending bug fixes to
> stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org but haven't been aggressive with cephfs because
> the code is less stable.  There will be catch-up required to get 3.14 in
> good working order.
>
> Definitely hear you that this important, just can't promise when we'll
> have the time to do it.  There's probably a half day's effort to pick out
> the right patches and make sure they build properly, and then some time to
> feed it through the test suite.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
