From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Pages still marked with private_2
Date: Sun, 11 Aug 2013 09:23:42 -0400
Message-ID: <CANP1eJH-o2gch_YsWXJwc7cr56SPMqKB6=UrnLy6L_z28R38PA@mail.gmail.com>
References: <CANP1eJFOu-QtyB-PoTRQpi2d_Xuy8NTm5nOPuwZ979qcoVtmVg@mail.gmail.com>
	<22942.1373993980@warthog.procyon.org.uk>
	<CANP1eJHg1+CRt4R3PBv_s9JefCiXYWpQ=+rkNBkOaVV+exhR+w@mail.gmail.com>
	<13152.1374765616@warthog.procyon.org.uk>
	<CANP1eJHFXCnnr05TQR0vmKXShcFHfhCsh14FbVCqw6hq2mbW2Q@mail.gmail.com>
	<CANP1eJF3tpYH=Abv4MMiqM5WQWDxcEwm-FP8NnWYhM9NNgYaQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <CANP1eJF3tpYH=Abv4MMiqM5WQWDxcEwm-FP8NnWYhM9NNgYaQg@mail.gmail.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: David Howells <dhowells@redhat.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
List-Id: ceph-devel.vger.kernel.org

David,

After a few more days of analysis. I think I know what happening here
and I'm going to assume that other filesystems (NFS, CIFS, ...) can
also exhibit the same issue. Here's my list of steps of how we get
into this problem. If you can tell me if I'm the right path with my
thinking that would be great. Also, if anyone from fsdevel can chime
in.

1. Kernel decides perform readahead for the file and calls the
address_space_operations::read_pages.
2. When fscache is enabled for ceph the first thing we try to do is
get the pages from the cache using fscache_read_or_alloc_pages.
3. Here the code does two things. First it starts the read on the data
and if there aren't in the cache it pre-marks the pages in the list
with a Private2 flag.
4. If we were not able to fully satisfy the read request from the
cache we continue to the filesystem's normal readpages code.
5. *This is where things go wrong*. Somewhere during the readpages
path the filesystem decides to bail early without populating all the
pages in the page list with data; this is perfectly valid (kernel
documentation explicitly says that if you encounter an error feel free
to bail.)
6. We return to the readahead code path. It attempts to clean up the
pages left in the page list and it notices that the pages is marked
with Private2 and then BUG.

So really the solution should be strait-forward. When we bail early in
readpages we need to call fscache_uncache_page for the un-consumed
pages in page list that were marked by a previous call to
fscache_read_or_alloc_pages.

I think other filesystems can exhibit this behavior. First, other
filesystems can also easily bail in
address_space_operations::readpages and currently I don't see CIFS or
NFS cleaning up the page_list before returning. Second, a quick search
of the cachefs list (and google) reveals that other folks ran into a
similar stack trace (via the readahead path) and a page being marked
with Private2 on cleanup. So it seams like having a new
fscache_uncache_pages convenience function that does this for a whole
page list would make it easier to fix all the filesystems.

Am I on the right path here?

Thanks,
- Milosz

On Thu, Aug 8, 2013 at 1:25 PM, Milosz Tanski <milosz@adfin.com> wrote:
> After taking a look in the code I'm guessing that this is caused by
> the cachefiles module in cachefiles_allocate_pages(). It's the only
> places where the pages get marked as with private_2 in that path. My
> guess is that we mark all the pages in the list with private_2 but we
> don't consume the whole and when readahead does the page list cleanup
> it finds these. Any insight if I'm on the right path?
>
> - Milosz
>
> On Thu, Aug 8, 2013 at 12:44 PM, Milosz Tanski <milosz@adfin.com> wrote:
>> David,
>>
>> I retired with your fixes and my newer Ceph implementation. I still
>> see the same issue with a page being marked as private_2 in the
>> readahead cleanup code. I understand what happens, but not why it
>> happens.
>>
>> On the plus side I haven't seen any hard crashes yet, but I'm putting
>> it through the paces. I'm not sure if me reworking the fscache code in
>> Ceph or your wait_on_atomic fix but I'm fine sharing the blame /
>> success here.
>>
>> [48532035.686695] BUG: Bad page state in process petabucket  pfn:3b5ffb
>> [48532035.686715] page:ffffea000ed7fec0 count:0 mapcount:0 mapping:
>>       (null) index:0x2c
>> [48532035.686720] page flags: 0x200000000001000(private_2)
>> [48532035.686724] Modules linked in: ceph libceph cachefiles
>> auth_rpcgss oid_registry nfsv4 microcode nfs fscache lockd sunrpc
>> raid10 raid456 async_pq async_xor async_memcpy async_raid6_recov
>> async_tx raid1 raid0 multipath linear btrfs raid6_pq lzo_compress xor
>> zlib_deflate libcrc32c
>> [48532035.686735] CPU: 1 PID: 32420 Comm: petabucket Tainted: G    B
>>      3.10.0-virtual #45
>> [48532035.686736]  0000000000000001 ffff88042bf57a48 ffffffff815523f2
>> ffff88042bf57a68
>> [48532035.686738]  ffffffff8111def7 ffff880400000001 ffffea000ed7fec0
>> ffff88042bf57aa8
>> [48532035.686740]  ffffffff8111e49e 0000000000000000 ffffea000ed7fec0
>> 0200000000001000
>> [48532035.686742] Call Trace:
>> [48532035.686745]  [<ffffffff815523f2>] dump_stack+0x19/0x1b
>> [48532035.686747]  [<ffffffff8111def7>] bad_page+0xc7/0x120
>> [48532035.686749]  [<ffffffff8111e49e>] free_pages_prepare+0x10e/0x120
>> [48532035.686751]  [<ffffffff8111fc80>] free_hot_cold_page+0x40/0x170
>> [48532035.686753]  [<ffffffff81123507>] __put_single_page+0x27/0x30
>> [48532035.686755]  [<ffffffff81123df5>] put_page+0x25/0x40
>> [48532035.686757]  [<ffffffff81123e66>] put_pages_list+0x56/0x70
>> [48532035.686759]  [<ffffffff81122a98>] __do_page_cache_readahead+0x1b8/0x260
>> [48532035.686762]  [<ffffffff81122ea1>] ra_submit+0x21/0x30
>> [48532035.686835]  [<ffffffff81118f64>] filemap_fault+0x254/0x490
>> [48532035.686838]  [<ffffffff8113a74f>] __do_fault+0x6f/0x4e0
>> [48532035.686840]  [<ffffffff81008c33>] ? pte_mfn_to_pfn+0x93/0x110
>> [48532035.686842]  [<ffffffff8113d856>] handle_pte_fault+0xf6/0x930
>> [48532035.686845]  [<ffffffff81008c33>] ? pte_mfn_to_pfn+0x93/0x110
>> [48532035.686847]  [<ffffffff81008cce>] ? xen_pmd_val+0xe/0x10
>> [48532035.686849]  [<ffffffff81005469>] ?
>> __raw_callee_save_xen_pmd_val+0x11/0x1e
>> [48532035.686851]  [<ffffffff8113f361>] handle_mm_fault+0x251/0x370
>> [48532035.686853]  [<ffffffff812b0ac4>] ? call_rwsem_down_read_failed+0x14/0x30
>> [48532035.686870]  [<ffffffff8155bffa>] __do_page_fault+0x1aa/0x550
>> [48532035.686872]  [<ffffffff81003e03>] ? xen_write_msr_safe+0xa3/0xc0
>> [48532035.686874]  [<ffffffff81004ec2>] ? xen_mc_flush+0xb2/0x1c0
>> [48532035.686876]  [<ffffffff8100483d>] ? xen_clts+0x8d/0x190
>> [48532035.686878]  [<ffffffff81556ad6>] ? __schedule+0x3a6/0x820
>> [48532035.686880]  [<ffffffff8155c3ae>] do_page_fault+0xe/0x10
>> [48532035.686882]  [<ffffffff81558818>] page_fault+0x28/0x30
>>
>> - Milosz
>>
>> On Thu, Jul 25, 2013 at 11:20 AM, David Howells <dhowells@redhat.com> wrote:
>>> Milosz Tanski <milosz@adfin.com> wrote:
>>>
>>>> In my case I'm seeing this in cases when all user space have these
>>>> opened R/O. Like I wrote this out weeks ago, rebooted... so nobody is
>>>> using R/W.
>>>
>>> I gave Linus a patch to fix wait_on_atomic_t() which he has committed.  Can
>>> you see if that fixed the problem?  I'm not sure it will, but it's worth
>>> checking.
>>>
>>> David
