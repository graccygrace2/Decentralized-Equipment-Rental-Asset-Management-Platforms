# Decentralized Equipment Rental Asset Management Platform

A comprehensive blockchain-based platform for managing equipment rental operations, built on the Stacks blockchain using Clarity smart contracts.

## Overview

This platform provides a complete solution for decentralized equipment rental management, featuring:

- **Equipment Owner Verification**: Validates and manages equipment rental companies
- **Asset Tracking**: Comprehensive tracking of rental equipment assets and their status
- **Rental Management**: Complete rental lifecycle management from booking to completion
- **Maintenance Coordination**: Scheduled and emergency maintenance management
- **Utilization Optimization**: Analytics and recommendations for maximizing equipment utilization

## Architecture

The platform consists of five interconnected smart contracts:

### 1. Equipment Owner Verification Contract (\`equipment-owner-verification.clar\`)
- Company registration and verification
- Owner validation and status management
- Verification status tracking

### 2. Asset Tracking Contract (\`asset-tracking.clar\`)
- Asset registration and management
- Real-time status tracking (Available, Rented, Maintenance, Retired)
- Location tracking and history logging
- Asset event history

### 3. Rental Management Contract (\`rental-management.clar\`)
- Rental booking and confirmation
- Payment processing and deposit management
- Rental lifecycle management
- Cost calculation and billing

### 4. Maintenance Coordination Contract (\`maintenance-coordination.clar\`)
- Maintenance scheduling (Routine, Repair, Inspection, Emergency)
- Technician assignment and tracking
- Maintenance cost management
- Asset maintenance history

### 5. Utilization Optimization Contract (\`utilization-optimization.clar\`)
- Utilization metrics calculation
- Revenue and performance analytics
- Dynamic pricing recommendations
- Demand-based optimization

## Features

### For Equipment Owners
- Register and verify company credentials
- Add and manage equipment inventory
- Track asset utilization and revenue
- Schedule and coordinate maintenance
- Receive optimization recommendations

### For Renters
- Browse available equipment
- Book and manage rentals
- Track rental history
- Make secure payments

### For Maintenance Providers
- Receive maintenance assignments
- Update maintenance status
- Record completion and costs

## Smart Contract Functions

### Equipment Owner Verification
- \`register-company\`: Register a new equipment rental company
- \`verify-company\`: Verify a registered company (admin only)
- \`deactivate-company\`: Deactivate a company (admin only)
- \`get-company-info\`: Retrieve company information
- \`is-company-verified\`: Check verification status

### Asset Tracking
- \`register-asset\`: Register new equipment asset
- \`update-asset-status\`: Update asset availability status
- \`update-asset-location\`: Update asset location
- \`get-asset-info\`: Retrieve asset information
- \`is-asset-available\`: Check asset availability

### Rental Management
- \`create-rental\`: Create new rental booking
- \`confirm-rental\`: Confirm rental agreement
- \`complete-rental\`: Mark rental as completed
- \`cancel-rental\`: Cancel rental booking
- \`calculate-rental-cost\`: Calculate total rental cost

### Maintenance Coordination
- \`schedule-maintenance\`: Schedule maintenance work
- \`start-maintenance\`: Begin maintenance work
- \`complete-maintenance\`: Complete maintenance work
- \`cancel-maintenance\`: Cancel scheduled maintenance
- \`is-maintenance-due\`: Check if maintenance is due

### Utilization Optimization
- \`record-rental-completion\`: Record completed rental for analytics
- \`record-maintenance-period\`: Record maintenance downtime
- \`get-utilization-metrics\`: Get asset utilization statistics
- \`get-optimization-recommendations\`: Get pricing and utilization recommendations

## Installation

1. Clone the repository
2. Install dependencies: \`npm install\`
3. Deploy contracts to Stacks blockchain
4. Configure contract addresses in your application

## Testing

Run the test suite using Vitest:

\`\`\`bash
npm test
\`\`\`

Tests cover all major contract functions and edge cases:
- Equipment owner verification flows
- Asset registration and tracking
- Rental lifecycle management
- Maintenance coordination
- Utilization optimization calculations

## Usage Examples

### Register a Company
\`\`\`clarity
(contract-call? .equipment-owner-verification register-company "ABC Equipment Rentals" "REG123456")
\`\`\`

### Register an Asset
\`\`\`clarity
(contract-call? .asset-tracking register-asset u1 "Excavator" "CAT 320" "SN123456" u500 "Warehouse A")
\`\`\`

### Create a Rental
\`\`\`clarity
(contract-call? .rental-management create-rental u1 u1000 u1007 u1000)
\`\`\`

### Schedule Maintenance
\`\`\`clarity
(contract-call? .maintenance-coordination schedule-maintenance u1 u1 u1100 "Regular maintenance" u200)
\`\`\`

## Security Considerations

- All contracts include proper authorization checks
- Asset ownership verification before operations
- Rental status validation for state changes
- Maintenance scheduling conflicts prevention
- Payment and deposit management security

## Future Enhancements

- Integration with IoT devices for real-time asset tracking
- Advanced analytics and machine learning for demand prediction
- Multi-token payment support
- Insurance integration
- Mobile application development
- API gateway for third-party integrations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the GitHub repository or contact the development team.
\`\`\`

Finally, let's create the PR details file:
