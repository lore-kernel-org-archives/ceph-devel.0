From: Jack Culpepper <jackculpepper@gmail.com>
Subject: loadable object classes
Date: Thu, 4 Feb 2010 12:16:11 -0800
Message-ID: <261c158e1002041216u593cfef2vb82e4c65504a4af@mail.gmail.com>
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
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hey Sage and Ceph folks,

I am trying to understand the loadable class stuff, which seems really
cool. I see the objclass directory and cls_crypto.cc seems to be a
good example that I could copy and change around.

Does the code in cls_crypto.cc get linked into code at the storage node?

Is it run in userspace?

I see an exec() in librados.cc, and then testrados.c seems to be the
place where I would add a driver program to call whatever class I add?

You link to openssl for the crypto. Is it ok to link to other,
possibly huge libraries?

On the test system, will there be a special place to store the
libraries my class needs?

Thanks!

Jack

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
