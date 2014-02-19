From: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph GET latency
Date: Wed, 19 Feb 2014 11:09:22 -0800
Message-ID: <CABBk=J8M7HDZQ5DX6LPqHGB9u3aqS_SpTzMb1TZjor6W3x+3xw@mail.gmail.com>
References: <1392737074.11284.YahooMailNeo@web140905.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1392737074.11284.YahooMailNeo-N73d9BslFxUMe+d1jY/0H5EhsgyP+Z75VpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Guang Yang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Feb 18, 2014 at 7:24 AM, Guang Yang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> wrote:
> Hi ceph-users,
> We are using Ceph (radosgw) to store user generated images, as GET latency
> is critical for us, most recently I did some investigation over the GET path
> to understand where time spend.
>
> I first confirmed that the latency came from OSD (read op), so that we
> instrumented code to trace the GET request (read op at OSD side, to be more
> specific, each object with size [512K + 4M * x]  are splitted into [1 + x]
> chunks, each chunk needs one read op ), for each read op, it needs to go
> through the following steps:
>     1. Dispatch and take by a op thread to process (process not started).
>              0   - 20 ms,    94%
>              20 - 50 ms,    2%
>              50 - 100 ms,  2%
>               100ms+   ,         2%
>          For those having 20ms+ latency, half of them are due to waiting for
> pg lock (https://github.com/ceph/ceph/blob/dumpling/src/osd/OSD.cc#L7089),
> another half are yet to be investigated.
>
>     2. Get file xattr ('-'), which open the file and populate fd cache
> (https://github.com/ceph/ceph/blob/dumpling/src/os/FileStore.cc#L230).
>               0   - 20 ms,  80%
>               20 - 50 ms,   8%
>               50 - 100 ms, 7%
>               100ms+   ,      5%
>          The latency either comes from (from more to less): file path lookup
> (https://github.com/ceph/ceph/blob/dumpling/src/os/HashIndex.cc#L294), file
> open, or fd cache lookup /add.
>          Currently objects are store in level 6 or level 7 folder (due to
> http://tracker.ceph.com/issues/7207, I stopped folder splitting).
>
>     3. Get more xattrs, this is fast due to previous fd cache (rarely >
> 1ms).
>
>     4. Read the data.
>             0   - 20 ms,   84%
>             20 - 50 ms, 10%
>             50 - 100 ms, 4%
>             100ms+        , 2%
>
> I decreased vfs_cache_pressure from its default value 100 to 5 to make VFS
> favor dentry/inode cache over page cache, unfortunately it does not help.
>
> Long story short, most of the long latency read op comes from file system
> call (for cold data), as our workload mainly stores objects less than 500KB,
> so that it generates a large bunch of objects.
>
> I would like to ask if people experienced similar issue and if there is any
> suggestion I can try to boost the GET performance. On the other hand, PUT
> could be sacrificed.
>

Try looking at the perfcounters, see if there's any other throttling
happening. Also, make sure you have enough pgs for your data pool. One
other thing to try is disabling leveldb xattrs and see if it affects
your latency.

Yehuda
