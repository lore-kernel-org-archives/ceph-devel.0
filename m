From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Caps disagreement
Date: Fri, 22 Jan 2010 14:38:46 -0800
Message-ID: <a37615151001221438w431ffc0dj670ad36a3c325b1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel <ceph-devel@lists.sourceforge.net>, Sage Weil <sage@newdream.net>
List-Id: ceph-devel.vger.kernel.org

There is a problem that I was able to reproduce quite frequently, when
trying to untar the latest linux kernel source tree, running 'make
oldconfig' and then 'make -j2':
The make operation does not get through much progress and just hangs
there after the first few steps. The problem is timing sensitive, and
I wasn't able to reproduce it on my uml. What happens is that the mds
and the client disagree on some directory's caps. The causes that when
the mds sends a caps revocation request, the client ignores that
request, since it thinks that it has already revoked the specified
caps. Thus the mds waiting indefinitely for the client's response.
It seems that the root cause for the client-mds disagreement was that
while waiting for some mds readdir operation response, the client got
a signal (probably from another process) that made it return
ERESTARTSYS (btw, we should translate it to EINTR) and dropped the
actual mds response which would have updated the caps. So, a trivial
solution would be:

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index abc9776..1429ed0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1605,17 +1605,15 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
        if (!req->r_reply) {
                mutex_unlock(&mdsc->mutex);
                if (req->r_timeout) {
-                       err = (long)wait_for_completion_interruptible_timeout(
+                       err = (long)wait_for_completion_timeout(
                                &req->r_completion, req->r_timeout);
                        if (err == 0)
                                req->r_reply = ERR_PTR(-EIO);
                        else if (err < 0)
                                req->r_reply = ERR_PTR(err);
                } else {
-                        err = wait_for_completion_interruptible(
+                        wait_for_completion(
                                 &req->r_completion);
-                        if (err)
-                                req->r_reply = ERR_PTR(err);
                }
                mutex_lock(&mdsc->mutex);
        }

As we've already discussed that recently, the problem with that is
that we won't be able to ^C while there are pending mds operations. We
also need to think of some other recovery mechanism for such
situations. E.g., instead of ignoring caps revocation request that
(the client thinks that it) does nothing, the client should respond in
any case.

Yehuda

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
