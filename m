From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: many meta files in osd
Date: Tue, 28 Jan 2014 10:26:45 +0100
Message-ID: <CAMNMNTx-v2tWZMjgxKM2eRK6m5GqhyMqpGXBcR5ww3n5mX7pCg@mail.gmail.com>
References: <CAMNMNTw3OM-aoUAOAEJcN5BqsrL+4S79Ha20=xt5wE_56Jd5_w@mail.gmail.com>
	<CAMNMNTzUA-xbGrQnw_aq2XtUhpQcvo4qf1YBJrqk=sP1zKzMDw@mail.gmail.com>
	<CAMNMNTzXETisGUHmEGd5z9NCjU-k_fmFU7Dctgn32b33vHbTyQ@mail.gmail.com>
	<CAPYLRzhsLVRRBzSmYS25iDC50RRsBtHUmYmHWkwPNwtY-ASM5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzhsLVRRBzSmYS25iDC50RRsBtHUmYmHWkwPNwtY-ASM5w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
Thanks for Your response.
ceph -v
ceph version 0.67.5 (a60ac9194718083a4b6a225fc17cad6096c69bd1)

grep -i rgw /etc/ceph/ceph.conf  | grep -v socket
        rgw_cache_enabled = true
        rgw_cache_lru_size = 10000
        rgw_thread_pool_size = 2048
        rgw op thread timeout = 6000
        rgw print continue = false
        rgw_enable_ops_log = false
        debug rgw = 10
        rgw dns name = ocdn.eu


On my test cluster (the same version, and symulation of this case)
command "radosgw-admin gc process" didn't help :-(

--
Regards
Dominik


2014-01-27 Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> Looks like you got lost over the Christmas holidays; sorry!
> I'm not an expert on running rgw but it sounds like garbage collection
> isn't running or something. What version are you on, and have you done
> anything to set it up?
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
> On Sun, Jan 26, 2014 at 12:59 PM, Dominik Mostowiec
> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi,
>> It is safe to remove this files
>>> rados -p .rgw ls | grep '.bucket.meta.my_deleted_bucket:'
>> for deleted bucket via
>> rados -p .rgw rm .bucket.meta.my_deleted_bucket:default.4576.1
>>
>> I have a problem with eaten inodes on disks where is many of such files.
>>
>> --
>> Regards
>> Dominik
>>
>> 2013-12-10 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>> Is there any posibility to remove this meta files? (whithout recreate cluster)
>>> Files names:
>>> {path}.bucket.meta.test1:default.4110.{sequence number}__head_...
>>>
>>> --
>>> Regards
>>> Dominik
>>>
>>> 2013/12/8 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>> Hi,
>>>> My api app to put files to s3/ceph checks if bucket exists by create
>>>> this bucket.
>>>> Each bucket create command adds 2 meta files.
>>>>
>>>> -----
>>>> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
>>>> 44
>>>> root@vm-1:/vol0/ceph/osd# s3 -u create test1
>>>> Bucket successfully created.
>>>> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
>>>> 46
>>>> -----
>>>>
>>>> Unfortunately:
>>>> -----
>>>> root@vm-1:/vol0/ceph/osd# s3 -u delete test1
>>>> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
>>>> 46
>>>> -----
>>>>
>>>> Is there some way to remove this meta files from ceph?
>>>>
>>>> --
>>>> Regards
>>>> Dominik
>>>
>>>
>>>
>>> --
>>> Pozdrawiam
>>> Dominik
>>
>>
>>
>> --
>> Pozdrawiam
>> Dominik
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Pozdrawiam
Dominik
