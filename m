From: =?UTF-8?B?UGF3ZcWCIFNhZG93c2tp?= <ceph-Bj5ZXqqQV65mR6Xm/wNWPw@public.gmane.org>
Subject: Re: O_DIRECT on deep-scrub read
Date: Thu, 08 Oct 2015 10:11:10 +0200
Message-ID: <5616251E.8090104@sadziu.pl>
References: <56150598.1080604@sadziu.pl>
	<alpine.DEB.2.00.1510070748580.8667@cobra.newdream.net>
	<561577DD.1050107@redhat.com>
	<alpine.DEB.2.00.1510071349410.8667@cobra.newdream.net>
Reply-To: ceph-Bj5ZXqqQV65mR6Xm/wNWPw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1510071349410.8667-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, David Zafman <dzafman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 10/07/2015 10:52 PM, Sage Weil wrote:
> On Wed, 7 Oct 2015, David Zafman wrote:
>> There would be a benefit to doing fadvise POSIX_FADV_DONTNEED after 
>> deep-scrub reads for objects not recently accessed by clients.
> Yeah, it's the 'except for stuff already in cache' part that we don't do 
> (and the kernel doesn't give us a good interface for).  IIRC there was a 
> patch that guessed based on whether the obc was already in cache, which 
> seems like a pretty decent heuristic, but I forget if that was in the 
> final version.

I've run some tests and it look like on XFS cache is discarded on
O_DIRECT write and read but on EXT4 is discarded only on O_DIRECT write.
I've found some patches to add support for "read only if in page cache"
(preadv2/RWF_NONBLOCK) but can't find them in kernel source. Maybe
Milosz Tanski can tell more about that. I think it could help a bit
during deep scrub.

>> I see the NewStore objectstore sometimes using the O_DIRECT  flag for writes.
>> This concerns me because the open(2) man pages says:
>>
>> "Applications should avoid mixing O_DIRECT and normal I/O to the same file,
>> and especially to overlapping byte regions in the same file.  Even when the
>> filesystem correctly handles the coherency issues in this situation, overall
>> I/O throughput is likely to be slower than using either mode alone."
> Yeah: an O_DIRECT write will do a cache flush on the write range, so if 
> there was already dirty data in cache you'll write twice.  There's 
> similarly an invalidate on read.  I need to go back through the newstore 
> code and see how the modes are being mixed and how it can be avoided...
>
> sage
>
>
>> On 10/7/15 7:50 AM, Sage Weil wrote:
>>> It's not, but it would not be ahrd to do this.  There are fadvise-style
>>> hints being passed down that could trigger O_DIRECT reads in this case.
>>> That may not be the best choice, though--it won't use data that happens
>>> to be in cache and it'll also throw it out..
>>>
>>> On Wed, 7 Oct 2015, Pawe? Sadowski wrote:
>>>
>>>> Hi,
>>>>
>>>> Can anyone tell if deep scrub is done using O_DIRECT flag or not? I'm
>>>> not able to verify that in source code.
>>>>
>>>> If not would it be possible to add such feature (maybe config option) to
>>>> help keeping Linux page cache in better shape?
>>>>
>>>> Thanks,

-- 
PS
