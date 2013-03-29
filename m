From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: corruption of active mmapped files in btrfs snapshots
Date: Fri, 29 Mar 2013 06:56:06 -0300
Message-ID: <orwqsqr0ll.fsf@livre.home>
References: <orhak8fm0u.fsf@livre.home>
	<20130322180705.27874.96638@localhost.localdomain>
	<20130322203142.27874.84834@localhost.localdomain>
	<20130326000840.14340.30047@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <20130326000840.14340.30047@localhost.localdomain> (Chris Mason's
	message of "Mon, 25 Mar 2013 20:08:40 -0400")
Sender: linux-btrfs-owner@vger.kernel.org
To: Chris Mason <chris.mason@fusionio.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mar 25, 2013, Chris Mason <chris.mason@fusionio.com> wrote:

> This patch changes our compression code to call clear_page_dirty_for_io
> before we compress, and then redirty the pages if the compression fails.

> Alexandre, many thanks for tracking this down into a well defined use
> case. 

Thanks for the patch, it's run flawlessly since I started gradually
rolling it out onto my ceph OSDs on Monday!  Ship it! :-)

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
