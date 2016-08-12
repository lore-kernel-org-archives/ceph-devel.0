From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Questions about Accepter::stop()
Date: Fri, 12 Aug 2016 22:40:33 +0200
Message-ID: <3492e51f-021b-2c6e-2242-2237add24784@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25350 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328AbcHLUko (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 16:40:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

Hi,

Still working on finding out why my OSD is not comming back up.
Looking at the OSD it seems to recover, but it is not reported back to
the other OSD and mons.

Below some of the code from
	./src/msg/simple/Accepter.cc

Turns out that the thread freezes on the join, and the complicating
factor is that shoutdown always reports that
  accepter.stop shutdown failed:  errno 57 (57) Socket is not connected

Then the code goes into the join, and gets stuck in there.

So I've execluded that part of the code, and the close section.

That seems to work, but I would very much some more opinions on this.
Original code was doen by Sage, but John Spray added a bit of exclusion
on the join()

And even with this change I cannot complete
	cephtool-test-mon.sh
But I'm getting a lot further down the test.

--WjW


void Accepter::stop()
{
  done = true;
  ldout(msgr->cct,10) << __func__ << " accepter on: " << listen_sd << dendl;

  if (listen_sd >= 0) {
    if ( ::shutdown(listen_sd, SHUT_RDWR) < 0 ) {
      ldout(msgr->cct,0) << __func__ << " shutdown failed: "
              << " errno " << errno << " " << cpp_strerror(errno) << dendl;
    }
  }
  if (errno != ENOTCONN) {
    // wait for thread to stop before closing the socket, to avoid
    // racing against fd re-use.
    if (is_started()) {
        ldout(msgr->cct,0) << __func__ << " wait for thread to join." <<
dendl;
      join();
    }
  } else {
    listen_sd = -1;
  }

  if (listen_sd >= 0) {
    if ( ::close(listen_sd) < 0 ) {
      ldout(msgr->cct,0) << __func__ << "close failed: "
              << " errno " << errno << " " << cpp_strerror(errno) << dendl;
    }
    listen_sd = -1;
  }
  done = false;
}

	
