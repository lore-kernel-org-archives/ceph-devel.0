From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster stability
Date: Wed, 20 Feb 2019 19:57:20 +0530
Message-ID: <CANA9Uk5_FfQqEbZ7O3xp4PPy=cSYUwSf-xWVM6+5WnQO6YkqmQ@mail.gmail.com>
References: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw@mail.gmail.com>
 <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thats expected from Ceph by design. But in our case, we are using all
recommendation like rack failure domain, replication n/w,etc, still
face client IO performance issues during one OSD down..

On Tue, Feb 19, 2019 at 10:56 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> With a RACK failure domain, you should be able to have an entire rack powered down without noticing any major impact on the clients.  I regularly take down OSDs and nodes for maintenance and upgrades without seeing any problems with client IO.
>
> On Tue, Feb 12, 2019 at 5:01 AM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> Hello - I have a couple of questions on ceph cluster stability, even
>> we follow all recommendations as below:
>> - Having separate replication n/w and data n/w
>> - RACK is the failure domain
>> - Using SSDs for journals (1:4ratio)
>>
>> Q1 - If one OSD down, cluster IO down drastically and customer Apps impacted.
>> Q2 - what is stability ratio, like with above, is ceph cluster
>> workable condition, if one osd down or one node down,etc.
>>
>> Thanks
>> Swami
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
