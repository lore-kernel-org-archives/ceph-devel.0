From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: a metadata lost problem when mds breaks down
Date: Thu, 31 Aug 2017 15:31:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708311529150.20435@piezo.novalocal>
References: <1228685801.457671.1504191723500.ref@mail.yahoo.com>
 <1228685801.457671.1504191723500@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1228685801.457671.1504191723500-sAHhhX/85wgbqTNvkayDYw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Meyers <MarkMeyers.MMY-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 31 Aug 2017, Mark Meyers wrote:
> Hi:
> 
>         I encountered a metadata lost problem of files when testing the outcome of ceph mds's unpredictable breakdown. 
>         The test shell script is like(not real code):
> 
>         while i < 100000
>         do 
>             touch $i
>             i++
>         done
>         echo c > /proc/sysrq-trigger
> 
>         The script is run in the same machine which mds is running on, and the directory is mount point of cephfs. 
>         I created 10,000 files using touch command and forced the system to break down.
>         When the machine rebooted again, the number of new files created is smaller than 10000. So the metadata of those files are lost.
>         My question: Are those losts of metadata allowed by ceph? Or is this a bug of ceph mds which could be solved in the future? My ceph version is 12.1.0, ubuntu kernel version 4.4.0.
>         
>         Thanks for your reading, I really appreciate your rely. Thanks!

You have to call fsync(2) on the containing directory if you want metadata 
changes (link, unlink, rename, create, mknod, open(...O_CREAT)) to be 
stable... just like you have to call fsync(2) after write(2) if you want 
the data to be durable.  In the case of creating a file, calling fsync() 
on the new file is also sufficient to make the new file exist (on most 
file systems, including CephFS).

sage
