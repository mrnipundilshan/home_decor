const { PrismaClient } = require('@prisma/client');
const fs = require('fs');
const path = require('path');

const prisma = new PrismaClient();

async function main() {
    const filePath = path.join(__dirname, '../data/items.json');
    const jsonData = fs.readFileSync(filePath, 'utf8');
    const items = JSON.parse(jsonData);

    console.log(`Start seeding ${items.length} items...`);

    for (const item of items) {
        await prisma.item.upsert({
            where: { id: item.uuid }, // matching the unique ID
            update: {
                title: item.title,
                subtitle: item.subtitle,
                category: item.category,
                imageUrl: item.imageUrl,
                price: parseFloat(item.price), // Ensure it's a float
                rating: parseFloat(item.rating), // Ensure it's a float
            },
            create: {
                id: item.uuid,
                title: item.title,
                subtitle: item.subtitle,
                category: item.category,
                imageUrl: item.imageUrl,
                price: parseFloat(item.price),
                rating: parseFloat(item.rating),
            },
        });
    }

    console.log('Seeding finished.');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
