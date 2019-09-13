From: Jeff Layton <jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [coreutils PATCH v2 0/2] ls: convert to using statx when available
Date: Fri, 13 Sep 2019 06:58:03 -0400
Message-ID: <20190913105805.24669-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <coreutils-bounces+gcgcg-coreutils=m.gmane.org-mXXj517/zsQ@public.gmane.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/coreutils>,
 <mailto:coreutils-request-mXXj517/zsQ@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.gnu.org/archive/html/coreutils>
List-Post: <mailto:coreutils-mXXj517/zsQ@public.gmane.org>
List-Help: <mailto:coreutils-request-mXXj517/zsQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/coreutils>,
 <mailto:coreutils-request-mXXj517/zsQ@public.gmane.org?subject=subscribe>
Errors-To: coreutils-bounces+gcgcg-coreutils=m.gmane.org-mXXj517/zsQ@public.gmane.org
Sender: "coreutils" <coreutils-bounces+gcgcg-coreutils=m.gmane.org-mXXj517/zsQ@public.gmane.org>
To: coreutils-mXXj517/zsQ@public.gmane.org
Cc: adilger-m1MBpc4rdrD3fQ9qLvQP4Q@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

v2:
- add wrappers for stat_for_ino and fstat_for_ino, don't factor out loop
  detection
- style cleanups

Sending to a wider distribution list this time, as this may encourage
other filesystem maintainers to flesh out their statx implementations
to take advantage of this.

Original patch description follows:

This patchset converts the ls command to use statx instead of stat when
available. This allows ls to indicate interest in only certain inode
metadata.

This is potentially a win on networked/clustered/distributed
filesystems. In cases where we'd have to do a full, heavyweight stat()
call we can now do a much lighter statx() call.

As a real-world example, consider a filesystem like CephFS where one
client is actively writing to a file and another client does an
ls --color in the same directory. --color means that we need to fetch
the mode of the file.

Doing that with a stat() call means that we have to fetch the size and
mtime in addition to the mode. The MDS in that situation will have to
revoke caps in order to ensure that it has up-to-date values to report,
which disrupts the writer.

This has a measurable affect on performance. I ran a fio sequential
write test on one cephfs client and had a second client do "ls --color"
in a tight loop on the directory that held the file:

Baseline -- no activity on the second client:

  WRITE: bw=3D76.7MiB/s (80.4MB/s), 76.7MiB/s-76.7MiB/s (80.4MB/s-80.4MB/=
s), io=3D4600MiB (4824MB), run=3D60016-60016msec

Without this patch series, we see a noticable performance hit:

  WRITE: bw=3D70.4MiB/s (73.9MB/s), 70.4MiB/s-70.4MiB/s (73.9MB/s-73.9MB/=
s), io=3D4228MiB (4433MB), run=3D60012-60012msec

With this patch series, we gain most of that ground back:

  WRITE: bw=3D75.9MiB/s (79.6MB/s), 75.9MiB/s-75.9MiB/s (79.6MB/s-79.6MB/=
s), io=3D4555MiB (4776MB), run=3D60019-60019msec

Jeff Layton (2):
  stat: move struct statx to struct stat conversion routines to new
    header
  ls: use statx instead of stat when available

 src/ls.c    | 106 ++++++++++++++++++++++++++++++++++++++++++++++++----
 src/stat.c  |  32 +---------------
 src/statx.h |  54 ++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 38 deletions(-)
 create mode 100644 src/statx.h

--=20
2.21.0
