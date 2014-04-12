From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] fs: Disallow all fallocate operation on active
 swapfile
Date: Sat, 12 Apr 2014 08:22:25 -0700
Message-ID: <20140412152225.GC18047@infradead.org>
References: <1397242665-2183-1-git-send-email-lczerner@redhat.com>
 <1397242665-2183-4-git-send-email-lczerner@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ext4-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397242665-2183-4-git-send-email-lczerner@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
To: Lukas Czerner <lczerner@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, xfs@oss.sgi.com
List-Id: ceph-devel.vger.kernel.org

Given that the earlier patches were about races - what protects us
from swapon racing with the check outside the filesystem locks?

