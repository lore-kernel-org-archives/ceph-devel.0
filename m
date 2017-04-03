From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: deep-scrubbing
Date: Mon, 3 Apr 2017 22:31:00 +0530
Message-ID: <CANA9Uk6zQ-LDaiFzWt_GVE+Hg0_Yqzuj+Y_X5e3w4z9=h2m6wQ@mail.gmail.com>
References: <CANA9Uk5W8AhOjRnxmdQXQL1g5KmP6_eDLYuhMEL_=50npW=x4A@mail.gmail.com>
	<CANA9Uk55ca+U1LFxmrSF_ZBqiH1ifi9kaUpDUoarR10+B-6EPQ@mail.gmail.com>
	<alpine.DEB.2.11.1704031327440.12988@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1704031327440.12988-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thanks Sage.
We have older version Ceph (Firefly version), where I could not see
this behavior (is on Saturday, after enabling the deep-scrub @ 7AM
hours, I could not see the deep-scrub started for Friday's PG
deep-scrub)).
Is the deep-scrub's performed based on the time-stamp? For ex: a PG
deep-scrubbed on Friday 10AM and if its not deep-scrubed on the next
Friday 10AM, then Saturday 10AM its will be performed (assumed that
Saturday 7AM deep-scrub enabled).

Thanks
Swami

On Mon, Apr 3, 2017 at 6:57 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> On Mon, 3 Apr 2017, M Ranga Swami Reddy wrote:
>> + ceph-devel
>>
>> On Mon, Feb 27, 2017 at 3:54 PM, M Ranga Swami Reddy
>> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > Hello,
>> > I use a ceph cluster and its show the deeps scrub's PG distribution as below
>> > from "ceph pg dump" command:
>> >
>> >   ====
>> >    2000 Friday
>> >    1000 Saturday
>> >    4000  Sunday
>> > ==
>> >
>> > On Friday, I have disabled the deep-scrub due to some reason. If this case,
>> > all Friday's PG deep-scrub will be performed on Saturday or is it will be
>> > done on Next Friday?
>
> Saturday.
>
> ks
