From: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Subject: Re: cephfs survey results
Date: Tue, 04 Nov 2014 10:35:28 +0100
Message-ID: <54589DE0.9090308@42on.com>
References: <alpine.DEB.2.00.1411030649070.15135@cobra.newdream.net>
	<CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w@mail.gmail.com>
	<alpine.DEB.2.00.1411040057280.15135@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1411040057280.15135-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 11/04/2014 10:02 AM, Sage Weil wrote:
> On Tue, 4 Nov 2014, Blair Bethwaite wrote:
>> On 4 November 2014 01:50, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
>>> In the Ceph session at the OpenStack summit someone asked what the CephFS
>>> survey results looked like.
>>
>> Thanks Sage, that was me!
>>
>>>  Here's the link:
>>>
>>>         https://www.surveymonkey.com/results/SM-L5JV7WXL/
>>>
>>> In short, people want
>>>
>>> fsck
>>> multimds
>>> snapshots
>>> quotas
>>
>> TBH I'm a bit surprised by a couple of these and hope maybe you guys
>> will apply a certain amount of filtering on this...
>>
>> fsck and quotas were there for me, but multimds and snapshots are what
>> I'd consider "icing" features - they're nice to have but not on the
>> critical path to using cephfs instead of e.g. nfs in a production
>> setting. I'd have thought stuff like small file performance and
>> gateway support was much more relevant to uptake and
>> positive/pain-free UX. Interested to hear others rationale here.
> 
> Yeah, I agree, and am taking the results with a grain of salt.  I 
> think the results are heavily influenced by the order they were 
> originally listed (I whish surveymonkey would randomize is for each 
> person or something).
> 
> fsck is a clear #1.  Everybody wants multimds, but I think very few 
> actually need it at this point.  We'll be merging a soft quota patch 
> shortly, and things like performance (adding the inline data support to 
> the kernel client, for instance) will probably compete with getting 
> snapshots working (as part of a larger subvolume infrastructure).  That's 
> my guess at least; for now, we're really focused on fsck and hard 
> usability edges and haven't set priorities beyond that.
> 
> We're definitely interested in hearing feedback on this strategy, and on 
> peoples' experiences with giant so far...
> 

I think the approach is correct. Everybody I talk to wants to kick out
their NFS server, but you don't need multi MDS for that. Active/Standby
is just fine.

Wido

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
