From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: [PATCH 2/2] hw/9pfs: fix alignment issue when host
 filesystem block size is larger than client msize
Date: Fri, 19 Feb 2016 16:56:00 +0800
Message-ID: <56C6D8A0.2040502@gmail.com>
References: <56C02E4F.6030303@gmail.com> <87y4an8l93.fsf@linux.vnet.ibm.com>
	<56C41DE8.2030904@gmail.com> <87h9h7z9a0.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------030405040304090102000101"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <87h9h7z9a0.fsf@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: sage@newdream.net, haomaiwang@gmail.com, gkurz@linux.vnet.ibm.com, gfarnum@redhat.com, mst@redhat.com
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--------------030405040304090102000101
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aneesh,
> I am not sure I understand the details correctly. iounit is the size
> that we use in client_read to determine the  size in which
> we should request I/O from the client. But we still can't do I/O in size
> larger than s->msize. If you look at the client side (kernel 9p fs), you
> will find
>
> 	rsize = fid->iounit;
> 	if (!rsize || rsize > clnt->msize-P9_IOHDRSZ)
> 		rsize = clnt->msize - P9_IOHDRSZ;
Yes, I know this.
> if your iounit calculation ends up zero, that should be handled
> correctly by
>
>      if (!iounit) {
>          iounit = s->msize - P9_IOHDRSZ;
>      }
>      return iounit;
>
>
> So what is the issue here. ?
This will result in an alignment issue while mapping the I/O requested by
client into pages in the function of p9_nr_pages().

    int p9_nr_pages(char *data, int len)
    {
             unsigned long start_page, end_page;
             start_page =  (unsigned long)data >> PAGE_SHIFT;
             end_page = ((unsigned long)data + len + PAGE_SIZE - 1) >>
    PAGE_SHIFT;
             return end_page - start_page;
    }

Please see the following experiment I did without the fix.

1) Start qemu with cephfs,

    $ qemu-system-x86_64 /root/CentOS---6.6-64bit---2015-03-06-a.qcow2
    -smp 4 -m 4096 -fsdev
    cephfs,security_model=passthrough,id=fsdev0,path=/ -device
    virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=cephfs --enable-kvm
    -nographic -net nic -net tap,ifname=tap0,script=no,downscript=no


2) Mount the fs in the guest.

    [root@localhost ~]# mount -t 9p -o trans=virtio,version=9p2000.L
    cephfs /mnt
    [root@localhost ~]# ls -lah /mnt/8kfile
    -rw-r--r-- 1 root root 8.0K 2016-02-19 09:37 /mnt/8kfile

In this case, I used the default msize which is 8192(in Byte). Since cephfs
is using 4M as the f_bsize, the iounit will be 8168 as P9_IOHDRSZ is
equal to 24.

3) Run the following systemtap script to trace the paging result,

    [root@localhost ~]# cat p9_read.stp
    probe kernel.function("p9_virtio_zc_request").call
    {
         printf("p9_virtio_zc_request: inlen size is %d\n", int_arg(5));
    }

    probe kernel.function("p9_nr_pages").call
    {
         printf("p9_nr_pages: start_page = %ld\n", int_arg(1) >> 12);
         printf("p9_nr_pages: end_age = %ld\n", (int_arg(1) + 8168 +
    4096 -1) >> 12);
    }

4) The output I got when I copied out the file /mnt/8kfile to /tmp/ 
directory,

    p9_virtio_zc_request: inlen size is 8168
    p9_nr_pages: start_page = 34293757815
    p9_nr_pages: end_age = 34293757818

Per the text in red(start_page = 34293757815, end_page = 34293757818),
it turns out 8k data will be mapped into three pages. This could hurt the
performance.

Actually, I enabled the cephfs debug functionality added by me to see
how the data is distributed in this case, the result is as follows,

    CEPHFS_DEBUG: cephfs_preadv iov_len=4096
    CEPHFS_DEBUG: cephfs_preadv iov_len=4072
    CEPHFS_DEBUG: cephfs_preadv iov_len=24

This patch aims to fix this. And the result turns out it works quite 
well, all the
data is well aligned.

    p9_virtio_zc_request: inlen size is 4096
    p9_nr_pages: start_page = 34203171814
    p9_nr_pages: end_age = 34203171815
    p9_virtio_zc_request: inlen size is 4096
    p9_nr_pages: start_page = 34203171815
    p9_nr_pages: end_age = 34203171816

    CEPHFS_DEBUG: cephfs_preadv iov_len=4096
    CEPHFS_DEBUG: cephfs_preadv iov_len=4096

Thanks,
Jevon
> -aneesh
>


--------------030405040304090102000101
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Aneesh,<br>
    <blockquote cite="mid:87h9h7z9a0.fsf@linux.vnet.ibm.com" type="cite">
      <blockquote type="cite"> </blockquote>
      <pre wrap="">I am not sure I understand the details correctly. iounit is the size
that we use in client_read to determine the  size in which
we should request I/O from the client. But we still can't do I/O in size
larger than s-&gt;msize. If you look at the client side (kernel 9p fs), you
will find

	rsize = fid-&gt;iounit;
	if (!rsize || rsize &gt; clnt-&gt;msize-P9_IOHDRSZ)
		rsize = clnt-&gt;msize - P9_IOHDRSZ;</pre>
    </blockquote>
    Yes, I know this.<br>
    <blockquote cite="mid:87h9h7z9a0.fsf@linux.vnet.ibm.com" type="cite">
      <pre wrap="">if your iounit calculation ends up zero, that should be handled
correctly by

    if (!iounit) {
        iounit = s-&gt;msize - P9_IOHDRSZ;
    }
    return iounit;


So what is the issue here. ?</pre>
    </blockquote>
    This will result in an alignment issue while mapping the I/O
    requested by <br>
    client into pages in the function of p9_nr_pages(). <br>
    <blockquote>int p9_nr_pages(char *data, int len)<br>
      {<br>
              unsigned long start_page, end_page;<br>
              start_page =  (unsigned long)data &gt;&gt; PAGE_SHIFT;<br>
              end_page = ((unsigned long)data + len + PAGE_SIZE - 1)
      &gt;&gt; PAGE_SHIFT;<br>
              return end_page - start_page;<br>
      }<br>
    </blockquote>
    Please see the following experiment I did without the fix.<br>
    <br>
    1) Start qemu with cephfs,<br>
    <blockquote>$ qemu-system-x86_64
      /root/CentOS---6.6-64bit---2015-03-06-a.qcow2 -smp 4 -m 4096
      -fsdev cephfs,security_model=passthrough,id=fsdev0,path=/ -device
      virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=cephfs --enable-kvm
      -nographic -net nic -net tap,ifname=tap0,script=no,downscript=no<br>
    </blockquote>
    <br>
    2) Mount the fs in the guest.<br>
    <blockquote>[root@localhost ~]# mount -t 9p -o
      trans=virtio,version=9p2000.L cephfs /mnt<br>
      [root@localhost ~]# ls -lah /mnt/8kfile<br>
      -rw-r--r-- 1 root root 8.0K 2016-02-19 09:37 /mnt/8kfile<br>
    </blockquote>
    In this case, I used the default msize which is 8192(in Byte). Since
    cephfs <br>
    is using 4M as the f_bsize, the iounit will be 8168 as P9_IOHDRSZ is
    <br>
    equal to 24. <br>
    <br>
    3) Run the following systemtap script to trace the paging result, <br>
    <blockquote>[root@localhost ~]# cat p9_read.stp<br>
      probe kernel.function("p9_virtio_zc_request").call<br>
      {<br>
          printf("p9_virtio_zc_request: inlen size is %d\n",
      int_arg(5));<br>
      }<br>
      <br>
      probe kernel.function("p9_nr_pages").call<br>
      {<br>
          printf("p9_nr_pages: start_page = %ld\n", int_arg(1) &gt;&gt;
      12);<br>
          printf("p9_nr_pages: end_age = %ld\n", (int_arg(1) + 8168 +
      4096 -1) &gt;&gt; 12);<br>
      }<br>
    </blockquote>
    4) The output I got when I copied out the file /mnt/8kfile to /tmp/
    directory,<br>
    <blockquote>p9_virtio_zc_request: inlen size is 8168<br>
      <font color="#ff0000">p9_nr_pages: start_page = 34293757815<br>
        p9_nr_pages: end_age = 34293757818</font><br>
    </blockquote>
    Per the text in red(start_page = 34293757815, end_page =
    34293757818), <br>
    it turns out 8k data will be mapped into three pages. This could
    hurt the <br>
    performance.<br>
    <br>
    Actually, I enabled the cephfs debug functionality added by me to
    see <br>
    how the data is distributed in this case, the result is as follows,<br>
    <blockquote>CEPHFS_DEBUG: cephfs_preadv iov_len=4096<br>
      CEPHFS_DEBUG: cephfs_preadv iov_len=4072<br>
      CEPHFS_DEBUG: cephfs_preadv iov_len=24 <br>
    </blockquote>
    This patch aims to fix this. And the result turns out it works quite
    well, all the<br>
    data is well aligned.<br>
    <blockquote>p9_virtio_zc_request: inlen size is 4096<br>
      p9_nr_pages: start_page = 34203171814<br>
      p9_nr_pages: end_age = 34203171815<br>
      p9_virtio_zc_request: inlen size is 4096<br>
      p9_nr_pages: start_page = 34203171815<br>
      p9_nr_pages: end_age = 34203171816<br>
      <br>
      CEPHFS_DEBUG: cephfs_preadv iov_len=4096<br>
      CEPHFS_DEBUG: cephfs_preadv iov_len=4096<br>
      <br>
    </blockquote>
    Thanks,<br>
    Jevon<br>
    <blockquote cite="mid:87h9h7z9a0.fsf@linux.vnet.ibm.com" type="cite">
      <pre wrap="">-aneesh

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------030405040304090102000101--
