From: Owen Synge <osynge@suse.com>
Subject: Re: Fedora 22 systemd and rgw
Date: Tue, 04 Aug 2015 14:32:07 +0200
Message-ID: <55C0B0C7.7050907@suse.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <55BFBA99.4070205@suse.com> <alpine.DEB.2.00.1508031205360.22099@cobra.newdream.net> <55C0904A.8010902@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:33209 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S933860AbbHDMd6 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 4 Aug 2015 08:33:58 -0400
In-Reply-To: <55C0904A.8010902@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 08/04/2015 12:13 PM, Owen Synge wrote:
> On 08/03/2015 09:07 PM, Sage Weil wrote:
>> On Mon, 3 Aug 2015, Owen Synge wrote:

> I will check the rgw.

It is not working due to missing:

/usr/lib/ceph-radosgw/ceph-radosgw-prestart.sh

which is a useful check tool, available in this commit:

https://github.com/SUSE/ceph/commit/92ef2ecfe0c0c0b0df4c9349310f930057202305

I assume this got lost some where earlier, and should be placed in the
systemd directory in my opinion.

and some small permission issues resolved all is working fine.

(core dump on failing to read the key is a bit ugly)

Best regards

Owen

PS for other comments more important than this detail please see earlier
emails in this thread.
