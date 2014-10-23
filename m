From: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Filestore throttling
Date: Thu, 23 Oct 2014 04:30:27 +0000
Message-ID: <BLU175-W176682F001CDC16FC4FA67DF920@phx.gbl>
References: <BLU175-W34FC39734E69C620D262DEDF920@phx.gbl>,
	<alpine.DEB.2.00.1410222104080.10837@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1410222104080.10837-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
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

Thanks Sage for the quick response!

We are using firefly (v0.80.4 with a couple of back-ports). One observation we have is that during peering stage (especially if the OSD got down/in for several hours with high load), the peering OPs are in contention with normal OPs and thus bring extremely long latency (up to minutes) for client OPs, the contention happened in filestore for throttling budget, it also happened at dispatcher/op threads, I will send another email with more details after more investigation.

As for this one, I created a pull request #2779 to change the default value of filesotre_queue_max_ops to 500 (which is specified in the document but code is inconsistent), do you think we should make others as default as well?

Thanks,
Guang

----------------------------------------
> Date: Wed, 22 Oct 2014 21:06:21 -0700
> From: sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org
> To: yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org
> CC: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Subject: Re: Filestore throttling
>
> On Thu, 23 Oct 2014, GuangYang wrote:
>> Hello Cephers,
>> During our testing, I found that the filestore throttling became a limiting factor for performance, the four settings (with default value) are:
>> filestore queue max ops = 50
>> filestore queue max bytes = 100 << 20
>> filestore queue committing max ops = 500
>> filestore queue committing max bytes = 100 << 20
>>
>> My understanding is, if we lift the threshold, the response for op (end to end) could be improved a lot during high load, and that is one reason to have journal. The downside is that if there is a read following a successful write, the read might stuck longer as the object is not flushed.
>>
>> Is my understanding correct here?
>>
>> If that is the tradeoff and read after write is not a concern in our use case, can I lift the parameters to below values?
>> filestore queue max ops = 500
>> filestore queue max bytes = 200 << 20
>> filestore queue committing max ops = 500
>> filestore queue committing max bytes = 200 << 20
>>
>> It turns out very helpful during PG peering stage (e.g. OSD down and up).
>
> That looks reasonable to me.
>
> For peering, I think there isn't really any reason to block sooner rather
> than later. I wonder if we should try to mark those transactions such
> that they don't run up against the usual limits...
>
> Is this firefly or something later? Sometime after firefly Sam made some
> changes so that the OSD is more careful about waiting for PG metadata to
> be persisted before sharing state. I wonder if you will still see the
> same improvement now...
>
> sage
 		 	   		  
