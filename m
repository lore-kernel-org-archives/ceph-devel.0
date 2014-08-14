From: Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
Subject: Translating a RadosGW object name into a filename on
	disk
Date: Thu, 14 Aug 2014 11:34:53 -0700
Message-ID: <CADHZLBa+5dx+kojiSh+T7GmM_asCwhPTriTNr3ob2SUya+KFhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

In my effort to learn more of the details of Ceph, I'm trying to
figure out how to get from an object name in RadosGW, through the
layers, down to the files on disk.

clewis@clewis-mac ~ $ s3cmd ls s3://cpltest/
2014-08-13 23:02        14M  28dde9db15fdcb5a342493bc81f91151
s3://cpltest/vmware-freebsd-tools.tar.gz

Looking at the .rgw pool's contents tells me that the cpltest bucket
is default.73886.55:
root@dev-ceph0:/var/lib/ceph/osd/ceph-0/current# rados -p .rgw ls | grep cpltest
cpltest
.bucket.meta.cpltest:default.73886.55

The rados objects that belong to that bucket are:
root@dev-ceph0:~# rados -p .rgw.buckets ls | grep default.73886.55
default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_1
default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_3
default.73886.55_vmware-freebsd-tools.tar.gz
default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_2
default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_4


I know those shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_ files are the
rest of vmware-freebsd-tools.tar.gz.  I can infer that because this
bucket only has a single file (and the sum of the sizes matches).
With many files, I can't infer the link anymore.

How do I look up that link?

I tried reading the src/rgw/rgw_rados.cc, but I'm getting lost.



My real goal is the reverse.  I recently repaired an inconsistent PG.
The primary replica had the bad data, so I want to verify that the
repaired object is correct.  I have a database that stores the SHA256
of every object.  If I can get from the filename on disk back to an S3
object, I can verify the file.  If it's bad, I can restore from the
replicated zone.


Aside from today's task, I think it's really handy to understand these
low level details.  I know it's been handy in the past, when I had
disk corruption under my PostgreSQL database.  Knowing (and
practicing) ahead of time really saved me a lot of downtime then.


Thanks for any pointers.
