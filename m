From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Re: Redundancy with Ceph
Date: Mon, 5 Jul 2010 00:33:50 +0200
Message-ID: <201007050033.50739.cray@unix-ag.uni-kl.de>
References: <201007042234.46732.cray@unix-ag.uni-kl.de> <AANLkTimXBAtgOFYAoX3aoZN4mLhYlA4514CQcpzj_mQu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:37559 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291Ab0GDWdz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jul 2010 18:33:55 -0400
In-Reply-To: <AANLkTimXBAtgOFYAoX3aoZN4mLhYlA4514CQcpzj_mQu@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

Hi,

I created 2 servers and one client

Server 1 => mon, mds, osd
Server 2 => osd

I tried some tests with iozone and I don't think Server 2 is used.

Server 1:
# df | grep osd
/dev/sdc              10485760    600504   9885256   6% /data/osd1

Server 2:
# df | grep osd
/dev/sdc              10485760        32  10485728   1% /data/osd2

Client:
# df | grep osd
10.243.150.209:/      10485760    896000   9589760   9% /mnt/ceph

Theses stats don't look like there is any redundancy with the user data.

Server 1:
# ls /var/log/ceph/
ip-10-243-150-209.18773  ip-10-243-150-209.20598  mds.0   osd1.3
ip-10-243-150-209.18993  ip-10-243-150-209.20822  mon0    osd1.4
ip-10-243-150-209.19277  ip-10-243-150-209.20912  osd1    osd1.5
ip-10-243-150-209.19501  ip-10-243-150-209.20940  osd1.0  osd1.6
ip-10-243-150-209.19727  ip-10-243-150-209.20990  osd1.1  osd1.7
ip-10-243-150-209.19963  mds0                     osd1.2  stat

Server 2:
# ls /var/log/ceph/
ip-10-212-118-67.19342  osd2

How can I check if Server 2 is really recognized by Server 1? 

Best Regards,
   Christian 



Am Sonntag, 4. Juli 2010 schrieben Sie:
> On Sun, Jul 4, 2010 at 1:34 PM, Christian Baun <cray@unix-ag.uni-kl.de> wrote:
> > Hi,
> >
> > Is it possible to tell Ceph that the user data is stored in a redundant way across the osds?
> Could you clarify? What do you mean by "across the OSDs"?
> Obviously Ceph is aware of how many copies it makes.
> 


