From: Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Much more dentries than inodes, is that normal?
Date: Tue, 7 Mar 2017 23:05:17 +0800
Message-ID: <CAEYCsVKkT488SJTOqnQwjthjppJK5MTo7GnzTO3dRGKU94MP6g@mail.gmail.com>
References: <CAEYCsVL-_JihR5RcDPzajNhZk52sGdwHOxU1Xmsbb==fhMh39Q@mail.gmail.com>
	<CALe9h7d2CJzYDX9LWz9KqiGZXwCXj80ATXVeWHnS=p9SOVtKmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALe9h7d2CJzYDX9LWz9KqiGZXwCXj80ATXVeWHnS=p9SOVtKmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thanks John.

Very likely, note that mds_mem::ino + mds_cache::strays_created ~=
mds::inodes, plus the MDS was the active-standby one, and become
active days ago due to failover.

mds": {
        "inodes": 1291393,
}
"mds_cache": {
        "num_strays": 3559,
        "strays_created": 706120,
        "strays_purged": 702561
}
"mds_mem": {
        "ino": 584974,
}

I do have a cache dump from the mds via admin socket,  is there
anything I can get from it  to make 100% percent sure?


Xiaoxi

2017-03-07 22:20 GMT+08:00 John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> On Tue, Mar 7, 2017 at 9:17 AM, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi,
>>
>>       From the admin socket of mds, I got following data on our
>> production cephfs env, roughly we have 585K inodes and almost same
>> amount of caps, but we have>2x dentries than inodes.
>>
>>       I am pretty sure we dont use hard link intensively (if any).
>> And the #ino match with "rados ls --pool $my_data_pool}.
>>
>>       Thanks for any explanations, appreciate it.
>>
>>
>> "mds_mem": {
>>         "ino": 584974,
>>         "ino+": 1290944,
>>         "ino-": 705970,
>>         "dir": 25750,
>>         "dir+": 25750,
>>         "dir-": 0,
>>         "dn": 1291393,
>>         "dn+": 1997517,
>>         "dn-": 706124,
>>         "cap": 584560,
>>         "cap+": 2657008,
>>         "cap-": 2072448,
>>         "rss": 24599976,
>>         "heap": 166284,
>>         "malloc": 18446744073708721289,
>>         "buf": 0
>>     },
>>
>
> One possibility is that you have many "null" dentries, which are
> created when we do a lookup and a file is not found -- we create a
> special dentry to remember that that filename does not exist, so that
> we can return ENOENT quickly next time.  On pre-Kraken versions, null
> dentries can also be left behind after file deletions when the
> deletion is replayed on a standbyreplay MDS
> (http://tracker.ceph.com/issues/16919)
>
> John
>
>
>
>>
>> Xiaoxi
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
