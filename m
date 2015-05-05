From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/5] target/rbd: distributed lun reset support
Date: Tue, 5 May 2015 10:49:39 -0700
Message-ID: <20150505174939.GA21297@infradead.org>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <target-devel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Can you explain why you want to hook into the lun reset code?  I know
the PR code needs to issue implicit task aborts, but I don't
understand the need to do something with lun resets.

As for the API:  I would much prefer to have things at the block layer
in some form than adding side band protocol for specific functionality.
