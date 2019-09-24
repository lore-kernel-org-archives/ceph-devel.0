From: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ceph; pg scrub errors
Date: Wed, 25 Sep 2019 09:41:35 +1000
Message-ID: <CAF-wwdFvbTRDULTYQAK_3orwqcFLJZYQHcqPXd0d4kyF99orMw@mail.gmail.com>
References: <CANA9Uk7nUFcLc7L4-=3hGH-7Dcf4dt1+xVSrs7hDzgWdNB+vqw@mail.gmail.com>
 <CAANLjFq3HCJvd6R-17ip+-TqTYeQFk0Z2eSz+hkCr2B4jUyX7w@mail.gmail.com>
 <CANA9Uk53woKRHkOqRTRsthODL8+JOfXX4BEpNhriqdTb0wG4yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk53woKRHkOqRTRsthODL8+JOfXX4BEpNhriqdTb0wG4yw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Sep 24, 2019 at 10:51 PM M Ranga Swami Reddy
<swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Interestingly - "rados list-inconsistent-obj ${PG} --format=json"  not showing any objects inconsistent-obj.
> And also "rados list-missing-obj ${PG} --format=json" also not showing any missing or unfound objects.

Complete a scrub of ${PG} just before you run these commands.

>
> Thanks
> Swami
>
> On Mon, Sep 23, 2019 at 8:18 PM Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
>>
>> On Thu, Sep 19, 2019 at 4:34 AM M Ranga Swami Reddy
>> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >
>> > Hi-Iam using ceph 12.2.11. here I am getting a few scrub errors. To fix these scrub error I ran the "ceph pg repair <pg_id>".
>> > But scrub error not going and the repair is talking long time like 8-12 hours.
>>
>> Depending on the size of the PGs and how active the cluster is, it
>> could take a long time as it takes another deep scrub to happen to
>> clear the error status after a repair. Since it is not going away,
>> either the problem is too complicated to automatically repair and
>> needs to be done by hand, or the problem is repaired and when it
>> deep-scrubs to check it, the problem has reappeared or another problem
>> was found and the disk needs to be replaced.
>>
>> Try running:
>> rados list-inconsistent-obj ${PG} --format=json
>>
>> and see what the exact problems are.
>> ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Cheers,
Brad
