From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: OSD repair: on disk size does not match object info size
Date: Tue, 10 Sep 2013 10:40:37 +1000
Message-ID: <20130910004037.GA2080@onthe.net.au>
References: <20130909231643.GA31877@onthe.net.au>
 <alpine.DEB.2.00.1309091627100.23522@cobra.newdream.net>
 <20130910000145.GA857@onthe.net.au>
 <alpine.DEB.2.00.1309091712430.23522@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:60737 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab3IJAlH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 20:41:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1309091712430.23522@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 09, 2013 at 05:14:14PM -0700, Sage Weil wrote:
> On Tue, 10 Sep 2013, Chris Dunlop wrote:
>> On Mon, Sep 09, 2013 at 04:30:33PM -0700, Sage Weil wrote:
>>> On Tue, 10 Sep 2013, Chris Dunlop wrote:
>>>> G'day,
>>>> 
>>>> On 0.56.7-1~bpo70+1 I'm getting:
>>>> 
>>>> # ceph pg dump | grep inconsistent
>>>> 013-09-10-08:39:59 2.bc        2776    0       0       0       11521799680     162063  162063  active+clean+inconsistent       2013-09-10 08:38:38.482302      20512'699877    20360'13461026  [6,0]   [6,0]   20512'699877    2013-09-10 08:38:38.482264      20512'699877     2013-09-10 08:38:38.482264
>>>> 
>>>> # ceph pg repair 2.bc
>>>> instructing pg 2.bc on osd.6 to repair
>>>> 
>>>> # tail /var/log/ceph/ceph-osd.6.log
>>>> 2013-09-10 08:17:25.557926 7fef09c14700  0 log [ERR] : repair 2.bc 89ebebc/rbd_data.13a0c74b0dc51.00000000000107ec/head//2 on disk size (4194304) does not match object info size (4104192)
>>>> 2013-09-10 08:17:27.316112 7fef09c14700  0 log [ERR] : 2.bc repair 1 errors, 0 fixed
>>>> 
>>>> # ls -l 'ceph-6/current/2.bc_head/DIR_C/DIR_B/DIR_E/rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2'
>>>> -rw-r--r-- 1 root root 4194304 Sep  8 21:01 ceph-6/current/2.bc_head/DIR_C/DIR_B/DIR_E/rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2
>>>> # ls -l 'ceph-0/current/2.bc_head/DIR_C/DIR_B/DIR_E/rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2'
>>>> -rw-r--r-- 1 root root 4194304 Sep  8 21:01 ceph-0/current/2.bc_head/DIR_C/DIR_B/DIR_E/rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2
>>>> 
>>>> One possible solution would be to simply truncate the objects down to the
>>>> object info size, as recommended in this case:
>>>> 
>>>> http://www.spinics.net/lists/ceph-users/msg00793.html
>>>> 
>>>> However I'm a little concerned about that solution as the on-disk size is
>>>> exactly 4MB, which I think is the expected size of these objects, and matches
>>>> the size of all the other objects in the same directory, and the "extra" data
>>>> looks a little interesting, with "FILE0" blocks in there (what are those?):
>>>> 
>>>> # cd /var/lib/ceph/osd/ceph-6/current/2.bc_head/DIR_C/DIR_B/DIR_E/
>>>> # dd if='rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2' bs=1024 skip=4008 | od -c
>>>> 0000000   F   I   L   E   0  \0 003  \0 312   j   o   o  \0  \0  \0  \0
>>>> 0000020 001  \0 001  \0   8  \0 001  \0   X 001  \0  \0  \0 004  \0  \0
>>>> 0000040  \0  \0  \0  \0  \0  \0  \0  \0 006  \0  \0  \0 310   p 017  \0
>>>> 0000060 002  \0  \0  \0  \0  \0  \0  \0 020  \0  \0  \0   `  \0  \0  \0
>>>> ...
>>>> 0002000   F   I   L   E   0  \0 003  \0 002   k   o   o  \0  \0  \0  \0
>>>> 0002020 001  \0 001  \0   8  \0 001  \0   X 001  \0  \0  \0 004  \0  \0
>>>> 0002040  \0  \0  \0  \0  \0  \0  \0  \0 006  \0  \0  \0 311   p 017  \0
>>>> 0002060 002  \0  \0  \0  \0  \0  \0  \0 020  \0  \0  \0   `  \0  \0  \0
>>>> ...
>>>> 0004000   F   I   L   E   0  \0 003  \0 023   r   o   o  \0  \0  \0  \0
>>>> 0004020 001  \0 001  \0   8  \0 001  \0   X 001  \0  \0  \0 004  \0  \0
>>>> 0004040  \0  \0  \0  \0  \0  \0  \0  \0 006  \0  \0  \0 312   p 017  \0
>>>> 0004060 002  \0  \0  \0  \0  \0  \0  \0 020  \0  \0  \0   `  \0  \0  \0
>>>> 
>>>> Is it safe to simply truncate this object, or what other solutions might
>>>> be applicable?
>>> 
>>> The alternative is to edit the xattr.  That's harder, but better.  You'll 
>>> want grab the user.ceph._ xattr, change the the one instance of 4104192 to 
>>> 4194304, and then reset it.  You can use
>>> 
>>>  ceph-dencoder type object_info_t import /tmp/xattrfile decode dump_json
>>>
>>> to verify that it decodes properly before and after you make the edit.  I 
>>> like the 'attr' tool for getting/setting xattrs.
>> 
>> Can ceph-dencoder import the (modified) json and write out the
>> encoded binary suitable for setting in the xattr?
> 
> It can't, sadly.
>  
>> If not, what encoding is the xattr, so I can work out what I
>> need to do to make the change?
> 
> It's little-endian.  So 'printf "%x\n" $badsize' and look for that value 
> with hexedit or whatever, and check your work with ceph-dencoder.

OK, for the record:

# printf '%x\n' 4104192
3ea000
# printf '%x\n' 4194304
400000
# attr -q -g ceph._ 'rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2' > /tmp/attr.1
## Note: reversed bytes
# xxd /tmp/attr.1 | sed 's/a03e/0040/' | xxd -r > /tmp/attr.2
# diff -u \
  <(ceph-dencoder type object_info_t import /tmp/attr.1 decode dump_json) \
  <(ceph-dencoder type object_info_t import /tmp/attr.2 decode dump_json)
--- /dev/fd/63  2013-09-10 10:28:59.882470249 +1000
+++ /dev/fd/62  2013-09-10 10:28:59.882470249 +1000
@@ -9,7 +9,7 @@
   "version": "20274'699051",
   "prior_version": "20016'685946",
   "last_reqid": "client.91723.0:521009894",
-  "size": 4104192,
+  "size": 4194304,
   "mtime": "2013-09-08 21:01:45.543328",
   "lost": 0,
   "wrlock_by": "unknown.0.0:0",
# attr -s ceph._ 'rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2' < /tmp/attr.2

(And repeat the 'attr -s' on the secondary storage)

...and repairing again!

Thanks for your help.

Chris.
