From: Jevon Qiao <qiaojianfeng@unitedstack.com>
Subject: Re: [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Mon, 14 Mar 2016 10:02:43 +0800
Message-ID: <56E61BC3.1010505@unitedstack.com>
References: <1456933303-1225-1-git-send-email-scaleqiao@gmail.com>
	<20160309200243.5b00eea7@bahia.lab.toulouse-stg.fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20160309200243.5b00eea7@bahia.lab.toulouse-stg.fr.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: haomaiwang@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, sage@newdream.net, ceph-devel@vger.kernel.org, gfarnum@redhat.com
List-Id: ceph-devel.vger.kernel.org

Hi Greg,

Thank you very much for reviewing the code, I've revised the code per 
your comments, will post it later. Meanwhile, please see my answers to 
your questions below.
>
>> +    }
>> +    fs->dir = (DIR *)result;
>> +    if (!fs->dir) {
>> +        fprintf(stderr, "ceph_opendir return NULL for ceph_dir_result\n");
> Hmm... is this a message for the QEMU user, so that she can fix something and
> retry ? I suspect it is more for debugging purposes, in which case I'd rather
> add a result argument to trace_cephfs_opendir_return() above.
Actually, this message is mainly used for debugging.
> And BTW, can ceph_opendir() return success without filling the structure ?
I double checked the Ceph code, it can not. I've removed this error message.
>> +
>> +# hw/9pfs/9p-cephfs.c
>> +cephfs_lstat_return(char *path, int stmode, int stuid, int stgid, int stsize, int ret) "path %s stmode %d stuid %d stgid %d stsize %d ret %d"
>> +cephfs_readlink_return(char *path, int ret) "path %s ret %d"
>> +cephfs_open_return(char *path, int flags, int mode, int fd) "path %s flags %d mode %d fd %d"
>> +cephfs_opendir_return(char *path, int ret) "path %s ret %d"
>> +cephfs_rewinddir(void *dir) "dir %p"
>> +cephfs_telldir(void *dir) "dir %p"
>> +cephfs_readdir_r_return(void *tmpent, void *entry, int ret) "tmpent %p entry %p ret %d"
>> +cephfs_seekdir(void *dir, int off) "dir %p off %d"
>> +cephfs_preadv(int iovcnt, int len) "iovcnt %d len %d"
>> +cephfs_preadv_return(int iovcnt, int len, long ret) "iovcnt %d len %d ret %l"
> ret %ld
>
>> +cephfs_pwritev(int iovcnt, int len, int offset) "iovcnt %d len %d offset %d"
>> +cephfs_pwritev_return(int iovcnt, int len, int offset, long ret) "iovcnt %d len %d offset %d ret %l"cephfs_chmod(char *path, int fcmode) "path %s fcmode %d"
> ret %ld for cephfs_pwritev_return() and missing newline before cephfs_chmod()
>
> I'm wondering if this patch was build tested before being posted to the list.
Good catch. Yes, the code had been compiled and tested. However, it 
seems the compiler will not report this error until the trace point is 
used. Since 'cephfs_chmod' is not used in 9p-cephfs.c, so I just forget 
to test it. That's why the error was not found. I've already removed 
this trace point in the revision.

Thanks,
Jevon
>> +cephfs_chmod_return(char *path, int fcmode, int ret) "path %s fcmode %d ret %d"
>> +cephfs_mknod_return(char *path, int fcmode, uint32_t fcrdev, int ret) "path %s fcmode %d fcrdev %u ret %d"
>> +cephfs_mkdir_return(char *path, int fcmode, int ret) " path %s fcmode %d ret %d"
>> +cephfs_fstat_return(int fidtype, int fd, int stuid, int stgid, int stsize, int ret) "fidtype %d fd %d stuid %d stgid %d stsize %d ret %d"
>> +cephfs_open2_return(char *path, int flags, int fcmode) "path %s flags %d fcmode %d"
