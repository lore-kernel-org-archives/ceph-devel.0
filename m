From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Wed, 30 Jun 2010 14:05:34 +0200
Message-ID: <AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
	<Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58138 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab0F3MFh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jun 2010 08:05:37 -0400
Received: by wyf23 with SMTP id 23so128695wyf.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jun 2010 05:05:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello Sage,

It actually works better when removing the old deb pacakge;)... thanks!

The "pg 0.xxxx on [] is laggy" messages have also now disappeared.

Here is, just for information, the obtained two processes dbench
output (which is not so bad given the vm the system in running into):
Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX       1632     8.835   213.966
 Close           1237     0.377   157.360
 Rename            73    24.290   195.969
 Unlink           291     6.514   244.166
 Qpathinfo       1455     4.544   237.949
 Qfileinfo        311     0.233     5.723
 Qfsinfo          270     1.854   110.355
 Sfileinfo        168     3.090    34.291
 Find             552    11.182   192.610
 WriteX          1076     4.916   409.798
 ReadX           2437     0.408    61.635
 LockX              4     0.011     0.017
 UnlockX            4     0.006     0.009
 Flush            140     8.630   175.423

Throughput 2.88849 MB/sec  2 clients  2 procs  max_latency=3D409.805 ms

I however get the a bunch of metadata sync warnings on the cfuse side
"10.06.30_13:16:20.556187 7f2bc5817720 client4100 fsync - not syncing
metadata yet.. implement me"


On a different topic (sorry for the mix-up), pushing the journal on a
seperate partition give me the following crash:

--- debian-vm1# /usr/local/bin/cosd -c /etc/ceph/ceph.conf --monmap
/tmp/monmap.1924 -i 0 --mkfs --osd-data /data/osd0
 ** WARNING: Ceph is still under heavy development, and is only suitabl=
e for **
 **          testing and review.  Do not trust it with important data. =
      **
os/FileJournal.cc: In function 'void FileJournal::write_bl(off64_t&,
ceph::bufferlist&)':
os/FileJournal.cc:503: FAILED assert((bl.length() & ~ceph::_page_mask) =
=3D=3D 0)
 1: (FileJournal::do_write(ceph::buffer::list&)+0x2a0) [0x55adc0]
 2: (FileJournal::write_thread_entry()+0x1fa) [0x55db4a]
 3: (FileJournal::Writer::entry()+0xd) [0x54f41d]
 4: (Thread::_entry_func(void*)+0x7) [0x46bac7]
 5: (()+0x68ba) [0x7f5dfce098ba]
 6: (clone()+0x6d) [0x7f5dfc02401d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion*'
Aborted (core dumped)

root@debian-vm1:~# gdb /usr/local/bin/cosd -c core
(gdb) bt full
#0  0x00007f5dfbf87175 in raise () from /lib/libc.so.6
No symbol table info available.
#1  0x00007f5dfbf89f80 in abort () from /lib/libc.so.6
No symbol table info available.
#2  0x00007f5dfc81add5 in __gnu_cxx::__verbose_terminate_handler() ()
from /usr/lib/libstdc++.so.6
No symbol table info available.
#3  0x00007f5dfc819176 in ?? () from /usr/lib/libstdc++.so.6
No symbol table info available.
#4  0x00007f5dfc8191a3 in std::terminate() () from /usr/lib/libstdc++.s=
o.6
No symbol table info available.
#5  0x00007f5dfc81929e in __cxa_throw () from /usr/lib/libstdc++.so.6
No symbol table info available.
#6  0x00000000005abb38 in ceph::__ceph_assert_fail (assertion=3D0x5e4ed=
8
"(bl.length() & ~ceph::_page_mask) =3D=3D 0", file=3D<value optimized o=
ut>,
line=3D503,
    func=3D<value optimized out>) at common/assert.cc:30
No locals.
#7  0x0000000000557c60 in FileJournal::write_bl (this=3D0x24fd720,
pos=3D@0x7f5dfbd3cd68, bl=3D...) at os/FileJournal.cc:503
        __PRETTY_FUNCTION__ =3D "void FileJournal::write_bl(off64_t&,
ceph::bufferlist&)"
        err =3D <value optimized out>
#8  0x000000000055adc0 in FileJournal::do_write (this=3D0x24fd720,
bl=3D...) at os/FileJournal.cc:568
        __PRETTY_FUNCTION__ =3D "void FileJournal::do_write(ceph::buffe=
rlist&)"
        lat =3D {tv =3D {tv_sec =3D 4224962000, tv_usec =3D 32605}}
        hbp =3D {_raw =3D 0x2500450, _off =3D 0, _len =3D 1024}
        pos =3D 1024
        split =3D <value optimized out>
#9  0x000000000055db4a in FileJournal::write_thread_entry
(this=3D0x24fd720) at os/FileJournal.cc:657
        orig_ops =3D 1
        bl =3D {_buffers =3D {<std::_List_base<ceph::buffer::ptr,
std::allocator<ceph::buffer::ptr> >> =3D {
              _M_impl =3D
{<std::allocator<std::_List_node<ceph::buffer::ptr> >> =3D
{<__gnu_cxx::new_allocator<std::_List_node<ceph::buffer::ptr> >> =3D
{<No data fields>}, <No data fields>}, _M_node =3D {_M_next =3D 0x25003=
60,
_M_prev =3D 0x2500360}}}, <No data fields>}, _len =3D 5120, append_buff=
er
=3D {_raw =3D 0x25002d0, _off =3D 0, _len =3D 80}, last_p =3D {
            bl =3D 0x7f5dfbd3ce10, ls =3D 0x7f5dfbd3ce10, off =3D 0, p =
=3D
{_M_node =3D 0x7f5dfbd3ce10}, p_off =3D 0}}
        orig_bytes =3D 206
        r =3D 0
        __PRETTY_FUNCTION__ =3D "void FileJournal::write_thread_entry()=
"
#10 0x000000000054f41d in FileJournal::Writer::entry (this=3D<value
optimized out>) at os/FileJournal.h:140
No locals.
#11 0x000000000046bac7 in Thread::_entry_func (arg=3D0x800) at
=2E/common/Thread.h:39
        r =3D <value optimized out>
#12 0x00007f5dfce098ba in start_thread () from /lib/libpthread.so.0
No symbol table info available.
#13 0x00007f5dfc02401d in clone () from /lib/libc.so.6
No symbol table info available.
#14 0x0000000000000000 in ?? ()
No symbol table info available.
(gdb)

I don't have so much time to investigate right now but I'll give a try
later today.

Sebastien

[global]
       pid file =3D /var/run/ceph/$name.pid
[mon]
       debug ms =3D 1
       mon data =3D /data/mon$id
[mon0]
       host =3D debian-vm1
       mon addr =3D 127.0.0.1:6789
[mds]
       debug ms =3D 1
[mds0]
       host =3D debian-vm1
[osd]
       debug ms =3D 1
       sudo =3D true
       osd data =3D /data/osd$id
       osd journal =3D /ceph-journal/osd$id
       osd journal size =3D 256
       filestore journal writeahead =3D true
[osd0]
       host =3D debian-vm1


with
/dev/sda6 on /ceph-journal type ext3 (rw,user_xattr)
/dev/sda7 on /data type ext3 (rw,user_xattr)


2010/6/29 Sage Weil <sage@newdream.net>:
> Hi Sebastien,
>
> On Tue, 29 Jun 2010, S=E9bastien Paolacci wrote:
>> First of all, many thanks for this wonderful piece of software that
>> actually looks very promising. It's a segment that imho definitely
>> lack of credible open source alternatives to the (sometimes infamous
>> and inefficient) proprietary systems.
>
> Thanks!
>
>> So I've just pulled the unstable branch from last Sunday and are few
>> outcomes (local vm, sorry for that, but as for a first try...):
>>
>> - Build: transparent, which is actually not so common for an unstabl=
e
>> branch of a said to not be mature project ;). Thanks.
>>
>> - Config: it's a bit difficult to understand the real meaning of all
>> the available options (debian and suse dedicated pages are however
>> very helpful), so documentation is sparse, as expected, and I should
>> have start by reading the code anyway (so my bad at the end).
>>
>> - First setup attempt left me with a "mon fs missing 'whoami'.. did
>> you run mkcephfs?" (see end of mail) I just echoed a "0" in
>> "/data/mom0/whoami" and it did startup.
>
> It looks like when you ran /etc/init.d/ceph is tried to start
> /usr/bin/cmon, although I notice lots of /usr/local in your mkcephfs
> output. =A0Do you by chance build from source and then 'make install'=
, and
> then also install a .deb or .rpm? =A0The "mon fs missing 'whoami'" is=
 an old
> error message that no longer appears in the 'unstable' branch, so the=
re is
> an old binary or old source involved somewhere.
>
>> - cfuse -m 127.0.01:5678/ /mnt/ceph is eating all my memory and
>> crashes with a bad_alloc
>
> Fixed this.. there was an ip address parsing error. =A0The trailing '=
/'
> shouldn't be there, and wasn't getting ignored.
>
>> - cfuse /mnt/ceph is however working as expected. Creating files and
>> browsing /mnt/ceph content provide with the desired result, dbench -=
D
>> /mnt/ceph/ -t 10 2 however seems to endless wait for completion. On
>> the cfuse side, I'm getting (what seems to be) an endless serie of "=
pg
>> 0.xxx on [] is laggy"
>
> That means the OSD isn't responding for some request(s). =A0Did cosd =
start?
> Does a 'ceph -s' show some osds are 'up'? =A0If cosd crashed, the out=
put log
> or gdb backtrack would be helpful.
>
>> root@debian-vm1:/home/seb# cat /etc/ceph/ceph.conf | grep -v '^;'
>> [global]
>> =A0 =A0 =A0 =A0pid file =3D /var/run/ceph/$name.pid
>> =A0 =A0 =A0 =A0debug ms =3D 10
> I wouldn't put this in [global] or you will clutter up output from th=
ings
> like 'ceph -s'.
>> [mon]
> =A0 =A0 =A0 =A0debug ms =3D 1 =A0 =A0; is usually enough msgr output
>> =A0 =A0 =A0 =A0mon data =3D /data/mon$id
>> [mon0]
>> =A0 =A0 =A0 =A0host =3D debian-vm1
>> =A0 =A0 =A0 =A0mon addr =3D 127.0.0.1:6789
>> [mds]
> =A0 =A0 =A0 =A0debug ms =3D 1 =A0 =A0; is usually enough msgr output
>> [mds0]
>> =A0 =A0 =A0 =A0host =3D debian-vm1
>> [osd]
> =A0 =A0 =A0 =A0debug ms =3D 1 =A0 =A0; is usually enough msgr output
>> =A0 =A0 =A0 =A0sudo =3D true
>> =A0 =A0 =A0 =A0osd data =3D /data/osd$id
>> =A0 =A0 =A0 =A0osd journal =3D /data/osd$id/journal
>> =A0 =A0 =A0 =A0osd journal size =3D 128
>> =A0 =A0 =A0 =A0filestore journal writeahead =3D true
>> [osd0]
>> =A0 =A0 =A0 =A0host =3D debian-vm1
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
