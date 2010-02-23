From: "Talyansky, Roman" <roman.talyansky@sap.com>
Subject: Re: Write operation is stuck
Date: Tue, 23 Feb 2010 15:11:43 +0100
Message-ID: <C6A64D82E3A5D24B949315CFBC1FA1AD072A34414F@DEWDFECCR01.wdf.sap.corp>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002161032280.31640@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A238242@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002191007260.20757@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A34414FDEWDFECCR01wd_"
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1002191007260.20757@cobra.newdream.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A34414FDEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Sage,

As you advised us, we switched to the release 0.19 of ceph and ran into ano=
ther bug in the ceph client. When writing to a file with the O_SYNC flag,  =
"0" is always returned although the data is written to disk.
This poses a problem in our benchmark which uses the return value as number=
 of bytes written. Also it seems that such behavior infringes the POSIX wri=
te() contract.

Attached is a small unit test in c++.
The unit test creates 2 files which are exactly the same, both filled rando=
mly with numbers 0-9.
Afterwards the both files are closed.
Then one file is reopened and filled with 1's.

Running the test:
$ g++ temp.cc
$ ./a.out 100  (this is the number of bytes in the files)
Each time 0 is returned it is printed out on the screen.
Run the executable a.out from within a directory on a ceph file system.

After the program  finishes you will find 2 files:
./test  - filled with one's
./test.start - filled with random numeric data

If you run this test on NFS and ceph you will see that no errors are printe=
d out on the NFS file system, and 100 errors are printed out on ceph.

Thanks,

Roman & Roman

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]=20
Sent: Friday, February 19, 2010 8:39 PM
To: Talyansky, Roman
Cc: ceph-devel@lists.sourceforge.net
Subject: Re: [ceph-devel] Write operation is stuck

Hi Roman,

On Fri, 19 Feb 2010, Talyansky, Roman wrote:
> Since I test several ceph versions simultaneously I could confuse the err=
or checking at different nodes.
> I'll double check this and let you know.

Thanks.  If you haven't switched to the just-released 0.19, now might be=20
the time to do that.

> > It also looks like the IO is synchronous, which may have something=20
> > to do with your performance.  Are you mounting with -o sync or using=20
> > direct IO, or are multiple clients reading and writing to the same file=
 or=20
> > something?
>
> The IO is indeed synchronous. However the performance under ceph is much=
=20
> worse than even under nfs, which looks strange. I do not mount with -o=20
> synch. And in our experiments multiple clients read and write the same=20
> file.

If you are accessing the same file from multiple clients, then any=20
comparison with nfs is going to be misleading.  NFS provides only close to=
=20
open consistency, so IO will be buffered and inconsistent.  Ceph provides=20
fully consistent semantics by switching to synchronous IO when there are=20
multiple clients.  Ceph will be slower, but correct; nfs will be fast, but=
=20
incorrect.

If your application is smart enough to handle it's own consistency (each=20
client is writing to a different region of the file) then you probably=20
want something along the lines of O_LAZY [1], so that the application can=20
tell the FS not to worry about consistency and stick with buffered IO. =20
Unfortunately O_LAZY doesn't exist in Linux at this point.  There is some=20
preliminary support for it in Ceph... if that's what you're looking for,=20
we can cook up some patches for you.

If you can find us in #ceph on irc.oftc.net that might be a quicker way to=
=20
diagnose the performance problems with your workload.

Thanks!
sage

[1] http://www.pdl.cmu.edu/posix/docs/posix_lazy_io.pdf

--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A34414FDEWDFECCR01wd_
Content-Type: application/octet-stream; name="temp.cc"
Content-Description: temp.cc
Content-Disposition: attachment; filename="temp.cc"; size=1658;
	creation-date="Tue, 23 Feb 2010 14:22:44 GMT";
	modification-date="Tue, 23 Feb 2010 14:21:26 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8ZGlyZW50Lmg+CiNpbmNsdWRlIDxlcnJu
by5oPgojaW5jbHVkZSA8dmVjdG9yPgojaW5jbHVkZSA8c3RyaW5nPgojaW5jbHVkZSA8aW9zdHJl
YW0+CiNpbmNsdWRlIDxmc3RyZWFtPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxmY250
bC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8c3Ry
aW5nLmg+CnVzaW5nIG5hbWVzcGFjZSBzdGQ7CgoKI2RlZmluZSBCVUZfTEVOIDEwMDAwMAojZGVm
aW5lIEJFR0lOX0lOUFVUX0ZfTkFNRSAidGVzdC5zdGFydCIKI2RlZmluZSBGX05BTUUgInRlc3Qi
CmludCBtYWluKGludCBhcmdjLCBjaGFyKiogYXJndikKewoKCQkJCXN3aXRjaChhcmdjKXsKCQkJ
CQkJCQljYXNlIDI6CgkJCQkJCQkJCQkJCWNvdXQ8PCJGaWxlIHNpemUgaXMgIjw8YXRvaShhcmd2
WzFdKTw8ZW5kbDsJCQoJCQkJCQkJCQkJCQlicmVhazsJCgkJCQkJCQkJZGVmYXVsdDoKCQkJCQkJ
CQkJCQkJY2Vycjw8IlVzYWdlOiAiPDxhcmd2WzBdPDwiIHNpemUgb2YgZmlsZSI8PGVuZGw7CgkJ
CQkJCQkJCQkJCWV4aXQoMSk7CgkJCQl9CgkJCQlpbnQgZlNpemUJPSBhdG9pKGFyZ3ZbMV0pOwoJ
CQkJb2ZzdHJlYW0gYmVnaW5GaWxlOwoJCQkJb2ZzdHJlYW0gd29ya0ZpbGU7CgkJCQliZWdpbkZp
bGUub3BlbihCRUdJTl9JTlBVVF9GX05BTUUpOwoJCQkJd29ya0ZpbGUub3BlbihGX05BTUUpOwoK
CQkJCWludCByYW49MDsKCQkJCWZvcihpbnQgaT0wO2k8ZlNpemU7aSsrKXsKCQkJCQkJCQlyYW49
cmFuZCgpOwoJCQkJCQkJCXJhbj00OCtyYW4lMTA7CgkJCQkJCQkJYmVnaW5GaWxlPDwoY2hhcily
YW47CgkJCQkJCQkJd29ya0ZpbGU8PChjaGFyKXJhbjsKCQkJCX0KCQkJCWJlZ2luRmlsZS5jbG9z
ZSgpOwoJCQkJd29ya0ZpbGUuY2xvc2UoKTsKCgkJCQljaGFyIGJ1ZmZbXT17NDl9OwoJCQkJLy9T
dGFydCBmaWxsaW5nIGZpbGVzIHdpdGggb25lcwoJCQkJLy8KCgkJCQlpbnQgZmxhZ3MgPSBPX1NZ
TkN8T19SRFdSOwoJCQkJaW50IGZkID0gOjpvcGVuKEZfTkFNRSwgZmxhZ3MpOwoJCQkJaWYgKGZk
IDw9IDApIHsKCQkJCQkJCQljZXJyIDw8ICIgb3BlbiBwcm9ibGVtIHdpdGg6ICIgPDwgRl9OQU1F
IDw8IGVuZGw7CgkJCQl9CgoJCQkJZm9yKGludCBpID0gMDsgaSA8ZlNpemU7IGkrKyl7CgkJCQkJ
CQkJb2ZmX3QgcmVzID0gOjpsc2VlayhmZCwgaSwgU0VFS19TRVQpOwoJCQkJCQkJCWlmIChyZXMg
IT0gaSkgewoJCQkJCQkJCQkJCQljZXJyIDw8ICJzZWVrIG9wIGZhaWxlZCByZXM9IiA8PCByZXMg
PDwgIiBvZmZzZXQ9IiA8PCBpIDw8IGVuZGw7CgkJCQkJCQkJfQoJCQkJCQkJCXJlcyA9IDo6d3Jp
dGUoZmQsYnVmZiwxICk7CgkJCQkJCQkJaWYgKHJlcyAhPSAxKXsKCQkJCQkJCQkJCQkJY2VyciA8
PCAicmVzPSIgPDwgcmVzIDw8ICIgd3JpdGUgZXJyb3I9IiA8PCBzdHJlcnJvcihlcnJubykgPDwg
c3RkOjplbmRsOwoJCQkJCQkJCX0KCgkJCQl9CgoJCQkJaW50IHJlc19jbG9zZSA9IDo6Y2xvc2Uo
ZmQpOyAKCQkJCWlmIChyZXNfY2xvc2UgPT0gLTEpewoJCQkJCQkJCWNlcnIgPDwgImNsb3NlIGVy
cm9yPSIgPDwgc3RyZXJyb3IoZXJybm8pIDw8IHN0ZDo6ZW5kbDsKCQkJCX0KCgkJCQlleGl0KDAp
Owp9Cgo=

--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A34414FDEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A34414FDEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A34414FDEWDFECCR01wd_--
