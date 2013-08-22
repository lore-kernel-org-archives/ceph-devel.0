From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: bucket count limit
Date: Thu, 22 Aug 2013 16:30:57 +0200
Message-ID: <CAMNMNTzTWO+QWVuTWQBn-eyWdAOvh=dgXHqsy8XgftdAxMS1aQ@mail.gmail.com>
References: <CAMNMNTzJ+2sLGur-7QKz+r0FJijTm-iHGqeHTYBWgbUjxoQpvw@mail.gmail.com>
	<CABBk=J__eM5NG4GB7QpEQ_3LnaEp-sTLsC=bjc28EL5hdrjWuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABBk=J__eM5NG4GB7QpEQ_3LnaEp-sTLsC=bjc28EL5hdrjWuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thank's for your answer.

--
Regards
Dominik

2013/8/22 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> On Thu, Aug 22, 2013 at 7:11 AM, Dominik Mostowiec
> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi,
>> I think about sharding s3 buckets in CEPH cluster, create
>> bucket-per-XX (256 buckets) or even bucket-per-XXX (4096 buckets)
>> where XXX is sign from object md5 url.
>> Could this be the problem? (performance, or some limits)
>>
>
> The two issues that I can think of. One is that there's usually a 1000
> buckets per user limitation. This can be easily modified though.
> The second issue is that you might end up with a huge number of
> buckets per user, and at that point listing buckets may just take too
> long. We've seen in the past cases where listing large number of
> buckets (> 500k) took more than the client timeout period, which in
> turn retried and retried, which snowballed into a very high load on
> the gateway (as the original requests were still processing
> internally). However, this might not be an issue anymore, I do
> remember we had a problem with streamlining the list bucket responses
> which I think is already fixed. In any case, if you're not planning to
> list all the user's buckets then this is moot.
>
> Yehuda



-- 
Pozdrawiam
Dominik
