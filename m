From: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: how to see file object-mappings for cephfuse client
Date: Mon, 7 Dec 2015 11:21:52 +0800
Message-ID: <CAAM7YAkdHJ0jCWDhWBRX2v7tCiXxw7ZM3T39Lk5=6XHNCo2EOA@mail.gmail.com>
References: <F075EA5A8A3F8045B2A81359C8B5B07C5E3E8A52@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <F075EA5A8A3F8045B2A81359C8B5B07C5E3E8A52-JwQOC20i6vT3cnzPNjVLboSsE/coCuR8pWgKQ6/u3Fg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Wuxiangwei <wuxiangwei-vVzyEvZLFYE@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Dec 7, 2015 at 10:51 AM, Wuxiangwei <wuxiangwei-vVzyEvZLFYE@public.gmane.org> wrote:
> Hi, Everyone
>
> Recently I'm trying to figure out how to use ceph-fuse. If we mount cephfs as the kernel client, there is a 'cephfs' command tool (though it seems to be 'deprecated') with 'map' and 'show_location' commands to show the RADOS objects belonging to a given file. However, it doesn't work well for ceph-fuse, neither can I find a similar tool to see the mappings. Any suggestions?
> Thank you!

Rados objects  for a give inode is in form <inode number in hex>.xxxxxxxx.

To get a file's layout, you can use getfattr -n ceph.file.layout <file name>

To find a given object is stored on which OSDs, you can use command,
ceph osd map <cephfs data pool> <object name>

>
>
> -----------------------
> Wu Xiangwei
> Tel : 0571-86760875
> 2014 UIS 2, TEAM BORE
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
