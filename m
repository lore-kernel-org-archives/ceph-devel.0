From: Eric Eastman <eric.eastman-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org>
Subject: Re: chattr +i not working with cephfs
Date: Wed, 28 Jan 2015 08:38:37 -0700
Message-ID: <CA+9C14ZU-oUg9mqjJe1PaXTNcyUnuBnYXYjd5zFuDaG8MXs_Eg@mail.gmail.com>
References: <CA+9C14YA03rUAWs8N9kyPNJWyC3hBmo6SPwoLdOAe4CGA4HY9w@mail.gmail.com>
	<CAGd4Wr3f5+w4Aqv8RAcPHeJWhWwTF-yXpfQGnjkQ9fF6D7dPgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGd4Wr3f5+w4Aqv8RAcPHeJWhWwTF-yXpfQGnjkQ9fF6D7dPgw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <john.spray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thank you for the reply.  This is a feature that we would like to see.
Should I write a cephfs tracker report on this as a possible future
enhancement?

On Wed, Jan 28, 2015 at 6:24 AM, John Spray <john.spray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> We don't implement the GETFLAGS and SETFLAGS ioctls used for +i.
>
> Adding the ioctls is pretty easy, but then we need somewhere to put
> the flags.  Currently we don't store a "flags" attribute on inodes,
> but maybe we could borrow the high bits of the mode attribute for this
> if we wanted to implement it?
>
> CCing ceph-devel to see if Sage/Greg can offer any more background.
>
> John
>
> On Wed, Jan 28, 2015 at 1:24 AM, Eric Eastman
> <eric.eastman-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org> wrote:
>> Should chattr +i  work with cephfs?
>>
>> Using ceph v0.91 and a 3.18 kernel on the CephFS client, I tried this:
>>
>> # mount | grep ceph
>> 172.16.30.10:/ on /cephfs/test01 type ceph (name=cephfs,key=client.cephfs)
>> # echo 1 > /cephfs/test01/test.1
>> # ls -l /cephfs/test01/test.1
>> -rw-r--r-- 1 root root 2 Jan 27 19:09 /cephfs/test01/test.1
>> # chattr +i /cephfs/test01/test.1
>> chattr: Inappropriate ioctl for device while reading flags on
>> /cephfs/test01/test.1
>>
>> I also tried it using the FUSE interface:
>>
>> # ceph-fuse -m 172.16.30.10 /cephfs/fuse01/
>> ceph-fuse[5326]: starting ceph client
>> 2015-01-27 19:54:59.002563 7f6f8fbcb7c0 -1 init, newargv = 0x2ec2be0
>> newargc=11
>> ceph-fuse[5326]: starting fuse
>> # mount | grep ceph
>> ceph-fuse on /cephfs/fuse01 type fuse.ceph-fuse
>> (rw,nosuid,nodev,allow_other,default_permissions)
>> # echo 1 > /cephfs/fuse01/test02.dat
>> # chattr +i   /cephfs/fuse01/test02.dat
>> chattr: Invalid argument while reading flags on /cephfs/fuse01/test02.dat
>>
>> Eric
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
